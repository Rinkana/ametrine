module Ametrine
  struct Currency
    include Comparable(Currency)
    class_property currencies = {} of String => Currency

    property code : String
    property fraction : Int64

    def initialize(@code, fraction : Int)
      @fraction = fraction.to_i64

      @@currencies[code.downcase] = self
    end

    def <=>(other)
      code <=> other.code
    end

    def self.get(code : String)
      @@currencies[code.downcase]
    end
  end
end
