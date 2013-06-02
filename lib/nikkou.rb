require 'nokogiri'
require 'active_support/core_ext'
require 'tzinfo'

module Nikkou
end

directory = Pathname.new(File.dirname(File.absolute_path(__FILE__)))
Dir.glob(directory.join('nikkou', '*.rb')) { |file| require file }
Dir.glob(directory.join('nikkou', '**/*.rb')) { |file| require file }

Nokogiri::XML::Document.send(:include, Nikkou::Nokogiri::XML::Document)
Nokogiri::XML::Node.send(:include, Nikkou::Nokogiri::XML::Node)
Nokogiri::XML::NodeSet.send(:include, Nikkou::Nokogiri::XML::NodeSet)

Mechanize::Page.send(:include, Nikkou::Mechanize::Page) if defined?(Mechanize::Page)
