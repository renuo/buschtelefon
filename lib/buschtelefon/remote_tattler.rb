require "socket"

module Buschtelefon
  # No need to inheritance from Tattler because not all its features are available here (only #feed)
  class RemoteTattler
    attr_reader :host, :port

    def initialize(host:, port:, outbound_socket: UDPSocket.new)
      @host = host
      @port = port
      @outbound_socket = outbound_socket
    end

    def feed(gossip)
      # puts "#{@outbound_socket.local_address.ip_port} sending #{JSON.parse(gossip.message)['number']} to #{@port}"
      @outbound_socket.send(gossip.message, 0, @host, @port)
    end

    def inquire
      @outbound_socket.send("\x05", 0, @host, @port)
    end

    def to_s
      "#{@host}:#{@port}"
    end
  end
end
