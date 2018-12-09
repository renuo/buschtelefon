RSpec.describe Buschtelefon::NetTattler do
  let(:instance) { described_class.new }

  describe '#listen' do
    let(:message) { 'blub' }

    it 'receives a UDP packet' do
      expect(instance).to receive(:feed).with(an_instance_of(Buschtelefon::Gossip))

      receiver = Thread.new do
        instance.listen do |raw_message|
          expect(raw_message).to eq(message)
          break
        end
      end

      sleep(0.1)

      UDPSocket.new.send(message, 0, 'localhost', 9999)
      receiver.join
    end
  end
end
