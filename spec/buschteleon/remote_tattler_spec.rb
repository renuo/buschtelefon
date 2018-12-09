RSpec.describe Buschtelefon::RemoteTattler do
  let(:instance) { described_class.new(host: host, port: port) }
  let(:host) { 'localhost' }
  let(:port) { 1337 }

  describe '#feed' do
    let(:message) { 'blub' }

    it 'sends a UDP packet' do
      receiver = Thread.new do
        Socket.udp_server_loop(host, port) do |message, _message_source|
          expect(message).to eq(message)
          break
        end
      end

      sleep(0.1)
      instance.feed(double(message: message))
      receiver.join
    end
  end
end
