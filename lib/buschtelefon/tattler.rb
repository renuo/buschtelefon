module Buschtelefon
  class Tattler
    attr_reader :connections

    def initialize
      @connections = []
      @brain = Brain.new
    end

    def connect(tattler)
      @connections << tattler
      @connections.uniq!
    end

    def feed(gossip)
      return if @brain.contains?(gossip)

      @brain << gossip
      @connections.each { |tattler| tattler.feed(gossip) }
    end
  end
end
