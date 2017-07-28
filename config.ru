require 'fileutils'
require 'logger'
require 'faye'
require './check_secret.rb'

FileUtils.mkdir_p('log')

logfile = 'log/push-server.log'
File.open(logfile, 'w') {} unless File.exist?(logfile)

if ENV['RAILS_ENV'] == 'production'
  logger = Logger.new(logfile)
else
  logger = Logger.new(STDOUT)
end

logger.level = Logger::INFO
Faye.logger = logger

Faye::WebSocket.load_adapter('thin')

server = Faye::RackAdapter.new(
  mount: '/faye',
  timeout: 25
)
server.add_extension(CheckSecret.new)

run server
