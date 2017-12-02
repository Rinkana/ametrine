require "http"
require "./ametrine/*"

module Ametrine
  # TODO Put your code here
end

client = Ametrine::Client.new
client.sources << Ametrine::Sources::WebSocket.new("ws://127.0.0.1:8080")
client.run
