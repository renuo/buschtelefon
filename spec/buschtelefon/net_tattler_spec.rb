RSpec.describe Buschtelefon::NetTattler do
  let(:instance) { described_class.new }

  describe "#initialize" do
    context "when called without arguments" do
      it "assigns a random ports" do
        expect(described_class.new.port).not_to eq(described_class.new.port)
      end

      it "binds to all interfaces" do
        expect(described_class.new.host).to eq("127.0.0.1")
      end
    end

    context "when called with a port argument" do
      let(:instance) { described_class.new(port: 41337) }

      it "assigns a specific port" do
        expect(instance.port).to eq(41337)
      end
    end

    context "when called with a host argument" do
      let(:instance) { described_class.new(host: "0.0.0.0") }

      it "binds to a specific host" do
        expect(instance.host).to eq("0.0.0.0")
      end
    end
  end

  describe "#listen" do
    let(:gossip) { Buschtelefon::Gossip.new("blub") }

    it "receives a UDP packet and handles it" do
      expect(instance).to receive(:feed).with(gossip)
      yielded_gossip = nil

      receiver = Thread.new {
        instance.listen { |g| yielded_gossip = g }
      }

      sleep(0.1)
      UDPSocket.new.send(gossip.message, 0, "127.0.0.1", instance.port)
      sleep(0.1)

      expect(yielded_gossip).to eq(gossip)
      receiver.kill
    end

    it "handles knowledge inquiry" do
      expect(instance).not_to receive(:feed)
      yielded_gossip = nil

      receiver = Thread.new {
        instance.listen { |g| yielded_gossip = g }
      }

      sleep(0.1)
      UDPSocket.new.send("\x05", 0, "127.0.0.1", instance.port)
      sleep(0.1)

      expect(yielded_gossip).to be_nil
      receiver.kill
    end
  end

  describe "#connect_remote" do
    subject do
      -> { instance.connect_remote(host: "127.0.0.1", port: 0) }
    end

    context "when remote tattler isnt connected yet" do
      it { is_expected.to change(instance.connections, :count).from(0).to(1) }
    end

    context "when remote tattler is already connected" do
      before do
        instance.connect_remote(host: "127.0.0.1", port: 0)
      end

      it { is_expected.not_to change(instance.connections, :count) }
    end
  end

  describe "#inquire_remote_neighbors" do
    it "sends inquiry packets" do
      expect(instance.socket).to receive(:send).with("\x05", 0, "127.0.0.1", 15555)
      expect(instance.socket).to receive(:send).with("\x05", 0, "127.0.0.1", 15566)
      instance.connect_remote(host: "127.0.0.1", port: 15555)
      instance.connect_remote(host: "127.0.0.1", port: 15566)
      instance.inquire_remote_neighbors
    end
  end

  describe "#remote_connections" do
    subject { instance.remote_connections }

    context "when not connected" do
      it { is_expected.to be_empty }
    end

    context "when connected to remotes" do
      before do
        instance.connect_remote(host: "127.0.0.1", port: 0)
      end

      it { is_expected.to have_attributes(count: 1) }
    end
  end

  describe "#to_s" do
    subject { instance.to_s }

    let(:instance) { described_class.new(host: "127.0.0.1", port: 17730) }

    it { is_expected.to eq("127.0.0.1:17730") }
  end
end
