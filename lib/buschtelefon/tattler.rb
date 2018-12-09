module Buschtelefon
  class Tattler
    attr_reader :connections

    def initialize
      @connections = []
      @brain = Brain.new
    end

    def knowledge
      @brain.to_a
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

    def transfer_knowledge(tattler)
      connect(tattler)
      knowledge.each { |gossip| tattler.feed(gossip) }
    end
  end
end
