require 'spec_helper'

describe Nokogiri::XML::NodeSet do
  before(:all) do
    assets_directory = File.expand_path(File.join(File.dirname(__FILE__), 'files'))
    html_file = File.join(assets_directory, 'test.html')
    @html = Nokogiri::HTML.parse(File.read(html_file))
  end

  describe '.attr_equals' do
    it 'finds nodes' do
      nodes = @html.search('a').attr_equals('href', 'http://www.ipsum.com/')
      nodes.first.text.should == 'ipsum'
    end
  end

  describe '.attr_includes' do
    it 'finds nodes' do
      nodes = @html.search('a').attr_includes('href', 'ipsum.com')
      nodes.first.text.should == 'ipsum'
    end
  end

  describe '.attr_matches' do
    it 'finds nodes' do
      nodes = @html.search('a').attr_matches('href', /(lorem|ipsum)\.com/)
      nodes.first.text.should == 'ipsum'
    end

    it 'sets matches' do
      nodes = @html.search('a').attr_matches('href', /(lorem|ipsum)\.com/)
      nodes.first.matches.should == ['ipsum.com', 'ipsum']
    end
  end

  describe '.text_equals' do
    it 'finds nodes' do
      nodes = @html.search('a').text_equals('ipsum')
      nodes.first.text.should == 'ipsum'
    end
  end

  describe '.text_includes' do
    it 'finds nodes' do
      nodes = @html.search('a').text_includes('ipsum')
      nodes.first.text.should == 'ipsum'
    end
  end

  describe '.text_matches' do
    it 'finds nodes' do
      nodes = @html.search('a').text_matches(/(\d+) comments/)
      nodes.first.text.should == '12 comments'
    end

    it 'sets matches' do
      nodes = @html.search('a').text_matches(/(\d+) comments/)
      nodes.first.matches.should == ['12 comments', '12']
    end
  end
end