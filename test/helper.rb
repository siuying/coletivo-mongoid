require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'mongoid'
Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db("coletivo")
end
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'coletivo'
Mongoid.logger = Logger.new($stdout, :debug)


require 'test/unit'
require 'turn'
require 'shoulda'

Mongoid.database.collections.each do |coll|
  coll.remove if coll.name !~ /system/
end

class Test::Unit::TestCase
end
