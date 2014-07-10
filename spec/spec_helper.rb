ENV["RAILS_ENV"] ||= 'test'

require 'rspec'
require 'nikkou'

RSpec.configure do |config|
  config.order = 'random'
end