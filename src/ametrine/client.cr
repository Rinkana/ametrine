module Ametrine
  class Client
    property wallets = [] of Wallet
    property sources = [] of Sources::Base
    #property predictors = [] of Predictors::Base
    #property strategy = Strategies::Base

    def initialize

    end

    def run
      source_channel = Channel(String).new

      sources.each do |source|
        source.channel = source_channel

        spawn do
          source.run
        end
      end

      loop do
        add_history(source_channel.receive)
      end
    end

    def add_history(value : String)
      p value
    end
  end
end
