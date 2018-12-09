require 'socket'

module Buschtelefon
  # No need to inherit from Tattler in Ruby
  class RemoteTattler
    def initialize(host:, port:)
      @host = host
      @port = port
      @outbound_socket = UDPSocket.new
    end

    def feed(gossip)
      @outbound_socket.send(gossip.message, 0, @host, @port)
      puts "Sent \"#{gossip.message}\" to #{@host}:#{@port}"
    end
  end
end
