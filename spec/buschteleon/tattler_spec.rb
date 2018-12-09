RSpec.describe Buschtelefon::Tattler do
  let(:instance) { described_class.new }

  describe '#connections' do
    subject { instance.connections }
    it { is_expected.to eq([]) }
  end

  describe '#knowledge' do
    subject { instance.knowledge }
    it { is_expected.to eq([]) }
  end

  context 'when connected linearly' do
    let(:near_tattler) { described_class.new }
    let(:far_tattler) { described_class.new }
    let(:gossip) { Buschtelefon::Gossip.new('Tezos') }

    before(:each) do
      near_tattler.connect(far_tattler)
      instance.connect(near_tattler)
    end

    it 'tells others' do
      expect(near_tattler).to receive(:feed).with(gossip).and_call_original
      expect(far_tattler).to receive(:feed).with(gossip).and_call_original
      instance.feed(gossip)
    end
  end
end
