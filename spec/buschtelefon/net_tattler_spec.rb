RSpec.describe Buschtelefon::NetTattler do
  describe '#initialize' do
    context 'when called without a port argument' do
      let(:instance) { described_class.new }

      before do
        allow_any_instance_of(Kernel).to receive(:rand).and_return(4)
      end

      it 'assigns a random port' do
        expect(instance.port).to eq(4)
      end
    end
  end

  describe '#listen' do
    let(:instance) { described_class.new }
    let(:gossip) { Buschtelefon::Gossip.new('blub') }

    it 'receives a UDP packet and handles it' do
      expect(instance).to receive(:feed).with(gossip)
      yielded_gossip = nil

      receiver = Thread.new do
        instance.listen { |g| yielded_gossip = g }
      end

      sleep(0.1)
      UDPSocket.new.send(gossip.message, 0, 'localhost', instance.port)
      sleep(0.1)

      expect(yielded_gossip).to eq(gossip)
      receiver.kill
    end

    it 'handles knowledge inquiry' do
      expect(instance).not_to receive(:feed)
      yielded_gossip = nil

      receiver = Thread.new do
        instance.listen { |g| yielded_gossip = g }
      end

      sleep(0.1)
      UDPSocket.new.send("\x05", 0, 'localhost', instance.port)
      sleep(0.1)

      expect(yielded_gossip).to be_nil
      receiver.kill
    end
  end
end
