module Ametrine
  module Sources
    abstract class Base
      property! channel : Channel(String)

      abstract def run
    end
  end
end
