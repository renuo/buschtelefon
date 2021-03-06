RSpec.describe Buschtelefon::Brain do
  let(:instance) { described_class.new }
  let(:gossip) { Buschtelefon::Gossip.new("Gach") }
  let(:old_gossip) { instance_double(Buschtelefon::Gossip, message: "Gach", created_at: Time.new(1990)) }
  let(:new_gossip) { instance_double(Buschtelefon::Gossip, message: "Gach", created_at: Time.new(2018)) }

  it "can be initialized" do
    expect(instance).to be_a(described_class)
  end

  it "can be initialized with capacity" do
    expect(described_class.new(1)).to have_attributes(capacity: 1)
  end

  it "can receive new gossip" do
    instance << gossip
    expect(instance.to_a).to eq([gossip])
  end

  it "saves the same gossip only once" do
    instance << gossip
    instance << gossip
    expect(instance.to_a).to eq([gossip])
  end

  it "keeps gossip by timeliness" do
    instance << old_gossip
    instance << new_gossip
    expect(instance.to_a).to eq([new_gossip])
  end

  it "sorts gossip by timeliness" do
    instance << new_gossip
    instance << old_gossip
    expect(instance.to_a).to eq([new_gossip])
  end

  it "only keeps some capacity of gossips" do
    brain = described_class.new(5)
    %w[1 2 3 4 5 6 7 8 9].each { |message| brain << Buschtelefon::Gossip.new(message) }
    expect(brain.to_a.size).to eq(brain.capacity)
    expect(brain.to_a.map(&:message)).to eq(%w[9 8 7 6 5])
  end

  describe "#load_batch" do
    let(:old_gossip) { instance_double(Buschtelefon::Gossip, message: "Gach", created_at: Time.new(1990)) }
    let(:new_gossip) { instance_double(Buschtelefon::Gossip, message: "Blub", created_at: Time.new(2000)) }

    it "adds gossips in batches" do
      instance.load_batch([old_gossip, new_gossip])
      expect(instance.to_a).to contain_exactly(old_gossip, new_gossip)
    end

    it "adds gossips in batches and reorganizes" do
      instance.load_batch([new_gossip, old_gossip])
      expect(instance.to_a).to contain_exactly(old_gossip, new_gossip)
    end

    it "adds gossips in batches and keeps old gossips" do
      instance << old_gossip
      instance.load_batch([new_gossip])
      expect(instance.to_a).to contain_exactly(old_gossip, new_gossip)
    end
  end
end
