RSpec.describe Buschtelefon::Gossip do
  let(:instance) { described_class.new("Bitcoin") }

  describe "initialization" do
    it "can be initialized with a message" do
      expect(instance.message).to eq("Bitcoin")
    end

    it "gets a timestamp on initialization" do
      expect(instance.created_at).to be_within(0.1).of(Time.now.to_f)
    end
  end

  describe "comparison" do
    it "can identify equals by message" do
      a = described_class.new("Bitcoin")
      b = described_class.new("Bitcoin")
      expect(a).to eq(b)
    end

    it "can identify different gossips" do
      a = described_class.new("Bitcoin")
      b = described_class.new("Ethereum")
      expect(a).not_to eq(b)
    end
  end
end
