module Buschtelefon
  class Gossip
    attr_reader :created_at, :message

    def initialize(message)
      @created_at = Time.now.getutc
      @message = message
    end

    def ==(other)
      @message == other.message
    end
  end
end
