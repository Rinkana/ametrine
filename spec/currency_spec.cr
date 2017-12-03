require "./spec_helper"
Spec.before_each do
  Ametrine::Currency.currencies.clear
end

Spec.after_each do
  Ametrine::Currency.currencies.clear
end

describe Ametrine::Currency do
  describe "#initialize" do
    it "caches new currencies" do
      Ametrine::Currency.new("USD", 2)

      Ametrine::Currency.currencies.size.should eq(1)
    end
  end

  describe "#<=>" do
    it "compares based on code" do
      c1 = Ametrine::Currency.new("USD", 2)
      c2 = Ametrine::Currency.new("USD", 3)
      c3 = Ametrine::Currency.new("EUR", 2)

      (c1 == c2).should be_true
      (c1 == c3).should be_false
    end
  end

  describe "#self.get" do
    it "loads from the cache" do
      expect_raises {Ametrine::Currency.get("USD")}

      c1 = Ametrine::Currency.new("USD", 2)

      c1.should eq(Ametrine::Currency.get("USD"))
    end
  end
end
