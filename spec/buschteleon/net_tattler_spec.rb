RSpec.describe Buschtelefon::NetTattler do
  let(:instance) { described_class.new(port: 9999) }

  describe '#listen' do
    let(:gossip) { Buschtelefon::Gossip.new('blub') }

    around do |example|
      receiver = Thread.new { instance.listen }
      example.run
      receiver.kill
    end

    after do
      sleep(0.1) # Waiting for packets to be sent
    end

    it 'receives a UDP packet and handles it' do
      expect(instance).to receive(:feed).with(gossip)
      UDPSocket.new.send(gossip.message, 0, 'localhost', 9999)
    end

    it 'handles knowledge inquiry' do
      expect(instance).not_to receive(:feed)
      UDPSocket.new.send("\x05", 0, 'localhost', 9999)
    end
  end
end
