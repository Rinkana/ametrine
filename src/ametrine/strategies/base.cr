module Ametrine
  module Predictors
    abstract class Base
      property! channel : Channel(Nil)

      abstract def update
    end
  end
end
