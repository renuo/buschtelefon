RSpec.describe Buschtelefon::Brain do
  let(:instance) { described_class.new }
  let(:gossip) { Buschtelefon::Gossip.new('Gach') }
  let(:old_gossip) { instance_double(Buschtelefon::Gossip, message: 'Gach', created_at: Time.new(1990)) }
  let(:new_gossip) { instance_double(Buschtelefon::Gossip, message: 'Gach', created_at: Time.new(2018)) }

  it 'can be initialized' do
    expect(instance).to be_a(described_class)
  end

  it 'can be initialized with capacity' do
    expect(described_class.new(1)).to have_attributes(capacity: 1)
  end

  it 'can receive new gossip' do
    instance << gossip
    expect(instance.to_a).to eq([gossip])
  end

  it 'saves the same gossip only once' do
    instance << gossip
    instance << gossip
    expect(instance.to_a).to eq([gossip])
  end

  it 'keeps gossip by timeliness' do
    instance << old_gossip
    instance << new_gossip
    expect(instance.to_a).to eq([new_gossip])
  end

  it 'sorts gossip by timeliness' do
    instance << new_gossip
    instance << old_gossip
    expect(instance.to_a).to eq([new_gossip])
  end

  it 'only keeps some capacity of gossip' do
    brain = described_class.new(100)
    1337.times { |i| brain << Buschtelefon::Gossip.new("#{i}") }
    expect(brain.to_a.count).to eq(100)
  end
end
