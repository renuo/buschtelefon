RSpec.describe Buschtelefon::Tattler do
  let(:instance) { described_class.new }

  it 'can be initialize' do
    expect(instance).not_to be_nil
    expect(instance.connections).to eq([])
  end

  it 'can connect to other tattlers' do
    other_tattler = described_class.new
    expect { instance.connect(other_tattler) }.to change { instance.connections.count }.by(1)
  end

  context 'when connected linear' do
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
