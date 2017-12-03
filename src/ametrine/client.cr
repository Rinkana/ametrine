module Ametrine
  class Client
    property wallets = [] of Wallet
    property sources = [] of Sources::Base
    property predictors = [] of Predictors::Base
    #property strategy : Strategies::Base

    property active_order = "BUY BUY BUY"

    def initialize

    end

    def run
      channel = Channel(Nil).new # TODO: Convert to action
      spawn_sources(channel)
      spawn_predictors(channel)
      spawn_strategy(channel)

      loop { channel.receive }
    end

    def add_history(value : String)
      p "New history value: #{value}"
    end

    private def spawn_sources(root_channel : Channel(Nil))
      spawn do
        source_channel = Channel(String).new

        sources.each do |source|
          source.channel = source_channel
          spawn { source.run }
        end

        loop { add_history(source_channel.receive) }
      end
    end

    private def spawn_predictors(root_channel : Channel(Nil))
      spawn do
        prediction_channel = Channel(Nil).new

        predictors.each do |predictor|
          predictor.channel = prediction_channel
          spawn { loop { predictor.update; Fiber.yield } }
        end

        loop { prediction_channel.receive }
      end
    end

    private def spawn_strategy(root_channel : Channel(Nil))
      spawn do
        loop do
          Fiber.yield
        end
      end
    end
  end
end
