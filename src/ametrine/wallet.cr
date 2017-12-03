module Ametrine
  class Wallet
    getter currency : String
    getter balance : Int64
    getter exponent : Int8

    def initialize(@currency, @balance, @exponent)

    end

    #def initialize(currency, balance : Float64)
    #  new(currency)
    #end
  end
end
