require 'rubygems'
require 'bundler/setup'
require 'rspec'

RSpec.configure do |config|
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{Dir.pwd}/spec/support/**/*.rb"].each {|f| require f}
