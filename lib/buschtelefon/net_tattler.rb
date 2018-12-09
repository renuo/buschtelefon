require 'socket'
require_relative 'tattler'

module Buschtelefon
  class NetTattler < Tattler
    def initialize(port: 9999, &interceptor)
      super()
      @port = port
    end

    def listen(&_callback)
      puts "Started UDP server on #{@port}..."

      Socket.udp_server_loop(@port) do |message, message_source|
        puts "Got \"#{message}\" from #{message_source}"
        handle_incoming_message(message)
        yield(message)
      end
    end

    private

    def handle_incoming_message(message)
      feed(Gossip.new(message))
    end
  end
end

