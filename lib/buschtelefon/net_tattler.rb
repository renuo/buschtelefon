require 'socket'
require_relative 'tattler'

module Buschtelefon
  class NetTattler < Tattler
    def initialize(port: 9999)
      super()
      @port = port
    end

    def listen(&_callback)
      puts "Started UDP server on #{@port}..."

      Socket.udp_server_loop(@port) do |message, message_source|
        puts "Got \"#{message}\" from #{message_source}"
        if message == "\x05"
          handle_knowledge_inquiry(message_source)
        else
          handle_incoming_message(message)
          yield(message) if block_given?
        end
      end
    end

    private

    def handle_incoming_message(message)
      feed(Gossip.new(message))
    end

    def handle_knowledge_inquiry(message_source)
      transfer_knowledge(RemoteTattler.new(message_source.local_address))
    end
  end
end

