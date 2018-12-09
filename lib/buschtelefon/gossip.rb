module Buschtelefon
  class Gossip
    attr_reader :created_at, :message

    def initialize(message)
      @created_at = unix_timestamp_ms
      @message = message
    end

    def ==(other)
      @message == other.message
    end

    private

    def unix_timestamp_ms
      (Time.now.to_f * 1000).to_i
    end
  end
end
