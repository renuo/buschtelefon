require "socket"
require_relative "tattler"

module Buschtelefon
  class NetTattler < Tattler
    attr_accessor :host, :port, :socket

    def initialize(host: "127.0.0.1", port: 0)
      super()
      @socket = UDPSocket.new
      @socket.bind(host, port)
      @host = @socket.local_address.ip_address
      @port = @socket.local_address.ip_port
    end

    def listen(&_callback)
      puts "Started UDP server on #{@host}:#{@port}..."

      Socket.udp_server_loop_on([@socket]) do |message, message_source|
        remote_tattler = find_or_build_remote_tattler(
          host: message_source.remote_address.ip_address,
          port: message_source.remote_address.ip_port
        )

        if message == "\x05"
          # puts "#{@port} got inquiry from #{remote_tattler}. Is connected to #{@connections.inspect}"
          handle_knowledge_inquiry(remote_tattler)
        else
          gossip = Gossip.new(message)
          handle_incoming_gossip(gossip)
          yield(gossip, remote_tattler) if block_given?
        end
      end
    end

    def connect_remote(host:, port:)
      find_or_build_remote_tattler(host: host, port: port).tap do |remote_tattler|
        connect(remote_tattler)
      end
    end

    def inquire_remote_neighbors
      remote_connections.each { |remote_tattler| remote_tattler.inquire }
    end

    def remote_connections
      @connections.select { |tattler| tattler.is_a?(RemoteTattler) }
    end

    def to_s
      "#{@host}:#{@port}"
    end

    private

    def handle_incoming_gossip(gossip)
      feed(gossip)
    end

    # We just give out everything to the outbound port of the inquiry source
    def handle_knowledge_inquiry(remote_tattler)
      transfer_knowledge(remote_tattler)
    end

    def find_or_build_remote_tattler(host:, port:)
      remote_connections.find { |t| t.host == host && t.port == port } || build_remote_tattler(host: host, port: port)
    end

    def build_remote_tattler(host:, port:)
      RemoteTattler.new(host: host, port: port, outbound_socket: @socket)
    end
  end
end
