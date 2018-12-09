RSpec.describe Buschtelefon::NetTattler do
  let(:instance) { described_class.new }

  it 'initializes' do
    expect(instance.connections).to eq([])
  end
end
