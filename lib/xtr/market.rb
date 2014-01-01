module Xtr
  # Public: A market for an instrument pair.
  #
  # Examples
  #
  #   btcusd = Market.new :currency, :BTC, :USD
  #   aapl = Market.new :stock, :AAPL, :USD
  class Market
    attr_reader :type, :left, :right, :orderbook

    delegate :bids, :asks, :best_bid, :best_ask, :last_price,
      :add_order, :cancel_order, to: :orderbook

    # Public: Initialize a market.
    #
    # type  - The Symbol type name. Possible values: :currency, :stock.
    # left  - The Symbol left instrument name.
    # right - The Symbol right instrument name.
    def initialize(type, left, right)
      @type = type
      @left, @right = left, right
      @orderbook = Orderbook.new
    end

    def pair
      case type
      when :currency
        [@left.name, @right.name].join('/') # => BTC/USD
      when :stock
        [@right.name, @left.name].join(':') # => USD:AAPL
      end
    end

    def inspect
      "#<#{self.class.name} #{pair}>"
    end
  end
end
