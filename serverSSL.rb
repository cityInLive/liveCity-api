# encoding: utf-8

require_relative 'Server'

require 'webrick'
require 'webrick/https'
require 'openssl'

CERT_PATH = '/etc/letsencrypt/live/vlntn.pw/'

webrick_options = {
	:Host               => '0.0.0.0',
	:Port               => 8080,
	:Logger             => WEBrick::Log::new($stdout, WEBrick::Log::DEBUG),
	:DocumentRoot       => "/ruby/htdocs",
	:SSLEnable          => true,
	:SSLVerifyClient    => OpenSSL::SSL::VERIFY_NONE,
	:SSLCertificate     => OpenSSL::X509::Certificate.new(File.open(File.join(CERT_PATH, "fullchain.pem")).read),
	:SSLPrivateKey      => OpenSSL::PKey::RSA.new(File.open(File.join(CERT_PATH, "privkey.pem")).read),
	:SSLCertName        => [["CN", WEBrick::Utils::getservername]]
}

Rack::Handler::WEBrick.run Server, webrick_options
