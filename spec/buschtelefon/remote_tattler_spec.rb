RSpec.describe Buschtelefon::RemoteTattler do
  let(:instance) { described_class.new(host: host, port: port) }
  let(:host) { '127.0.0.1' }
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

      sleep(0.1) # wait for udp server to start
      instance.feed(double(message: message))
      receiver.join
    end
  end

  describe '#inquire' do
    it 'sends a UDP packet' do
      receiver = Thread.new do
        Socket.udp_server_loop(host, port) do |inquiry, _message_source|
          expect(inquiry).to eq("\x05")
          break
        end
      end

      sleep(0.1) # wait for udp server to start
      instance.inquire
      receiver.join
    end
  end


  describe '#to_s' do
    subject { instance.to_s }

    it { is_expected.to eq('127.0.0.1:1337') }
  end
end
