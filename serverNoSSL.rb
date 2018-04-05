# encoding: utf-8

require 'webrick'

require_relative 'Server'

Rack::Handler::WEBrick.run Server 
