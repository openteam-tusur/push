require 'faye'
require './check_secret.rb'

Faye::WebSocket.load_adapter('thin')

server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)
server.add_extension(CheckSecret.new)

run server
