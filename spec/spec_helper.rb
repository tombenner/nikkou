ENV["RAILS_ENV"] ||= 'test'

require 'rspec'
require 'nikkou'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter = 'documentation'
end