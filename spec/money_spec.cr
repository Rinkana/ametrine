require "./spec_helper"

Spec.before_each do
  Ametrine::Currency.currencies.clear
end

Spec.after_each do
  Ametrine::Currency.currencies.clear
end

describe Ametrine::Money do
  describe "#initialize" do
    it "accepts any integer value" do
      c1 = Ametrine::Currency.new("USD", 2)
      m1 = Ametrine::Money.new(100_i32, c1)

      m1.amount.should eq(100_i32)
      m1.amount.should be_a(Int64)
    end

    it "should retreive the currency when a string is given" do
      expect_raises { Ametrine::Money.new(100, "USD") }

      c1 = Ametrine::Currency.new("USD", 2)
      m1 = Ametrine::Money.new(100, "USD")

      m1.currency.should eq(c1)
    end
  end

  describe "#-" do
    it "should convert the value from positive to negative" do
      m1 = Ametrine::Money.new(100, Ametrine::Currency.new("USD", 2))

      (-m1).amount.should eq(-100)
    end

    it "substracts" do
      c1 = Ametrine::Currency.new("USD", 2)
      c2 = Ametrine::Currency.new("EUR", 2)
      m1 = Ametrine::Money.new(100, c1) # USD
      m2 = Ametrine::Money.new(100, c2) # EUR
      m3 = Ametrine::Money.new(70, c1) # USD

      expect_raises { m1 - m2 }
      (m1 - m3).amount.should eq(30)
    end
  end

  describe "#+" do
    it "adds" do
      c1 = Ametrine::Currency.new("USD", 2)
      c2 = Ametrine::Currency.new("EUR", 2)
      m1 = Ametrine::Money.new(100, c1) # USD
      m2 = Ametrine::Money.new(100, c2) # EUR
      m3 = Ametrine::Money.new(70, c1) # USD

      expect_raises { m1 + m2 }
      (m1 + m3).amount.should eq(170)
    end
  end

  describe "#*" do
    it "adds" do
      c1 = Ametrine::Currency.new("USD", 2)
      m1 = Ametrine::Money.new(100, c1)

      (m1 * 2).amount.should eq(200)
    end
  end

  describe "#/" do
    it "devides" do
      c1 = Ametrine::Currency.new("USD", 2)
      m1 = Ametrine::Money.new(100, c1)

      (m1 / 2).amount.should eq(50)
    end
  end

  describe "#%" do
    it "gives the remainder" do
      c1 = Ametrine::Currency.new("USD", 2)
      m1 = Ametrine::Money.new(100, c1)

      (m1 % 80).amount.should eq(20)
    end
  end

  describe "#abs" do
    it "gives the absolute value" do
      c1 = Ametrine::Currency.new("USD", 2)
      m1 = Ametrine::Money.new(100, c1)
      m2 = Ametrine::Money.new(-100, c1)

      (m1.abs).amount.should eq(100)
      (m2.abs).amount.should eq(100)
    end
  end

  describe "#ceil" do
    it "gives the same value" do
      c1 = Ametrine::Currency.new("USD", 2)
      m1 = Ametrine::Money.new(100, c1)

      (m1.ceil).should eq(m1)
    end
  end

  describe "#floor" do
    it "gives the same value" do
      c1 = Ametrine::Currency.new("USD", 2)
      m1 = Ametrine::Money.new(100, c1)

      (m1.floor).should eq(m1)
    end
  end

  describe "#round" do
    it "gives the same value" do
      c1 = Ametrine::Currency.new("USD", 2)
      m1 = Ametrine::Money.new(100, c1)

      (m1.round).should eq(m1)
    end
  end

  describe "#trunc" do
    it "gives the same value" do
      c1 = Ametrine::Currency.new("USD", 2)
      m1 = Ametrine::Money.new(100, c1)

      (m1.trunc).should eq(m1)
    end
  end

  describe "#**" do
    it "adds the exponent" do
      c1 = Ametrine::Currency.new("USD", 2)
      m1 = Ametrine::Money.new(100, c1)

      (m1 ** 2).amount.should eq(10000)
    end
  end

  describe "#<=>" do
    it "validates the currency" do
      c1 = Ametrine::Currency.new("USD", 2)
      c2 = Ametrine::Currency.new("EUR", 2)
      m1 = Ametrine::Money.new(100, c1)
      m2 = Ametrine::Money.new(100, c2)

      (m1 == "VAL").should be_false
      (m1 == m2).should be_false
      (m1 == m1).should be_true
    end

    it "checks the size" do
      c1 = Ametrine::Currency.new("USD", 2)
      m1 = Ametrine::Money.new(100, c1)
      m2 = Ametrine::Money.new(120, c1)

      (m1 <=> m2).should eq(-1)
      (m1 < m2).should be_true
      (m1 > m2).should be_false
    end
  end
end
