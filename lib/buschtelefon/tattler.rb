module Buschtelefon
  class Tattler
    attr_reader :connections

    def initialize
      @connections = []
      @brain = Brain.new
    end

    def connect(tattler)
      @connections << tattler unless @connections.include?(tattler)
    end

    def feed(gossip)
      old_gossip = @brain.contains?(gossip)
      @brain << gossip # refresh memory
      return if old_gossip

      @connections.each { |tattler| tattler.feed(gossip) }
    end
  end
end
