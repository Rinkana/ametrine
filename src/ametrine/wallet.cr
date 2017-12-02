module Ametrine
  class Wallet
    getter currency : String
    getter balance : Int64
    getter exponent : Int8

    def initialize(@currency, @balance, @exponent)

    end
  end
end
