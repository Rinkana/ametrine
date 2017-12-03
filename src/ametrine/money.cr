require "big"
module Ametrine
  struct Money
    include Comparable(Money)

    property amount : Int64
    property currency : Currency

    def initialize(amount : Int, @currency)
      @amount = amount.to_i64
    end

    def self.new(amount : Int, currency : String)
      new(amount, Currency.get(currency))
    end

    def -
      self.class.new(-amount, currency)
    end

    def -(other)
      raise "Currency mismatch" if currency != other.currency
      self.class.new(amount - other.amount, currency)
    end

    def +(other)
      raise "Currency mismatch" if currency != other.currency
      self.class.new(amount + other.amount, currency)
    end

    def *(other : Int)
      self.class.new(amount * other.to_i64, currency)
    end

    def /(other : Int)
      self.class.new(amount / other.to_i64, currency)
    end

    def %(other : Int)
      self.class.new(amount % other.to_i64, currency)
    end

    def abs
      self.class.new(amount.abs, currency)
    end

    def ceil
      self #.class.new(amount, currency)
    end

    def floor
      self #.class.new(amount, currency)
    end

    def round
      self #.class.new(amount, currency)
    end

    def trunc
      self #.class.new(amount, currency)
    end

    def **(exponent : Int)
      self.class.new(amount ** exponent, currency)
    end

    def <=>(other : Money)
      raise "Currency mismatch" if currency != other.currency
      amount <=> other.amount
    end

    def ==(other : Money)
      return false if currency != other.currency
      amount == other.amount
    end

    def to_big_f
      BigFloat.new(amount) / (10 ** currency.fraction)
    end
  end
end
