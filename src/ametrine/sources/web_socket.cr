require "./base"

module Ametrine
  module Sources
    class WebSocket < Base
      getter web_socket : HTTP::WebSocket

      def initialize(url : String)
        @web_socket = HTTP::WebSocket.new(url)
        @web_socket.on_message do |str|
          channel.send(str)
        end
      end

      def run
        @web_socket.run
      end
    end
  end
end
