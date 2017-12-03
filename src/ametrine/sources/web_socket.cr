require "./base"

module Ametrine
  module Sources
    class WebSocket < Base
      getter web_socket : HTTP::WebSocket

      def initialize(url : String)
        @web_socket = HTTP::WebSocket.new(url)
        @web_socket.on_message &->handle_message(String)
      end

      def run
        @web_socket.run
      end

      def handle_message(message)
        channel.send(message)
      end
    end
  end
end
