module Buschtelefon
  class Brain
    attr_reader :capacity

    def initialize(capacity = nil)
      @capacity = capacity
      @gossip_sink = []
    end

    def <<(gossip)
      @gossip_sink << gossip
      reorganize
    end

    def load_batch(gossips)
      @gossip_sink += gossips
      reorganize
    end

    def contains?(gossip)
      @gossip_sink.include?(gossip)
    end

    def to_a
      @gossip_sink
    end

    private

    def reorganize
      @gossip_sink.sort! { |x, y| y.created_at <=> x.created_at }
      @gossip_sink.uniq!(&:message)
      if @capacity
        @gossip_sink.slice!(capacity..-1) # only keep the newest
      end
    end
  end
end
