RSpec.describe Buschtelefon::Tattler do
  let(:instance) { described_class.new }

  describe "#connections" do
    subject { instance.connections }
    it { is_expected.to eq([]) }
  end

  describe "#knowledge" do
    subject { instance.knowledge }
    it { is_expected.to eq([]) }
  end

  describe "#connect" do
    let(:other_tattler) { described_class.new }

    it "connects to other tattlers" do
      expect { instance.connect(other_tattler) }.to change { instance.connections.count }.by(1)
    end

    context "when one tattler is connected" do
      before do
        instance.connect(other_tattler)
      end

      it "is accessible via connections" do
        expect { instance.connections.to contain_exactly(other_tattler) }
      end

      it "connects only once" do
        expect { instance.connect(other_tattler) }.not_to change { instance.connections.count }
      end
    end
  end

  describe "#feed" do
    context "when connected linearly" do
      let(:near_tattler) { described_class.new }
      let(:far_tattler) { described_class.new }
      let(:gossip) { Buschtelefon::Gossip.new("Tezos") }

      before(:each) do
        near_tattler.connect(far_tattler)
        instance.connect(near_tattler)
      end

      it "tells others" do
        expect(near_tattler).to receive(:feed).with(gossip).and_call_original
        expect(far_tattler).to receive(:feed).with(gossip).and_call_original
        instance.feed(gossip)
      end
    end
  end

  describe "#transfer_knowledge" do
    let(:other_tattler) { described_class.new }

    before do
      3.times { |i| instance.feed(Buschtelefon::Gossip.new(i.to_s)) }
    end

    it "transfers all brain content to other tattler" do
      expect { instance.transfer_knowledge(other_tattler) }
        .to change { instance.knowledge.count }.by(other_tattler.knowledge.count)
    end
  end

  describe "#load_messages" do
    it "loads messages into the brain" do
      expect { instance.load_messages(%w[news lol]) }.to change { instance.knowledge.count }.by(2)
    end
  end
end
