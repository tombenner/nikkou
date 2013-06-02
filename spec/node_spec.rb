require 'spec_helper'

describe Nokogiri::XML::Node do
  before(:all) do
    assets_directory = File.expand_path(File.join(File.dirname(__FILE__), 'files'))
    html_file = File.join(assets_directory, 'test.html')
    @html = Nokogiri::HTML.parse(File.read(html_file))
    @html.uri = 'http://www.loremipsum.com/page/2'
    
    # Set the time zone for .time
    Time.zone = 'Pacific Time (US & Canada)'
  end

  describe '.attr_equals' do
    it 'finds nodes' do
      nodes = @html.search('body').first.attr_equals('href', 'http://www.ipsum.com/')
      nodes.first.text.should == 'ipsum'
    end
  end

  describe '.attr_includes' do
    it 'finds nodes' do
      nodes = @html.search('body').first.attr_includes('href', 'ipsum.com')
      nodes.first.text.should == 'ipsum'
    end
  end

  describe '.attr_matches' do
    it 'finds nodes' do
      nodes = @html.search('body').first.attr_matches('href', /(lorem|ipsum)\.com/)
      nodes.first.text.should == 'ipsum'
    end

    it 'sets matches' do
      nodes = @html.search('body').first.attr_matches('href', /(lorem|ipsum)\.com/)
      nodes.first.matches.should == ['ipsum.com', 'ipsum']
    end
  end

  describe '.parse_text' do
    it 'converts the node\'s text to a node set' do
      nodes = @html.search('.xml-node').first.parse_text
      nodes.should be_an_instance_of(Nokogiri::XML::NodeSet)
    end

    it 'returns a node set that contains the correct content' do
      nodes = @html.search('.xml-node').first.parse_text
      nodes.search('.xml-encoded-node').length.should == 1
    end
  end

  describe '.text_equals' do
    it 'finds nodes' do
      nodes = @html.search('body').first.text_equals('ipsum')
      nodes.first.text.should == 'ipsum'
    end
  end

  describe '.text_includes' do
    it 'finds nodes' do
      nodes = @html.search('body').first.text_includes('ipsum')
      nodes.first.text.should == 'ipsum'
    end
  end

  describe '.text_matches' do
    it 'finds nodes' do
      nodes = @html.search('body').first.text_matches(/(\d+) comments/)
      nodes.first.text.should == '12 comments'
    end

    it 'sets matches' do
      nodes = @html.search('body').first.text_matches(/(\d+) comments/)
      nodes.first.matches.should == ['12 comments', '12']
    end
  end

  describe '.time' do
    it 'reads relative time' do
      @html.search('.post-published-at').first.time.to_i.should == (Time.now.utc - 3.hours).to_i
    end

    it 'reads attributes' do
      @html.search('.post-published-at').first.time(attribute: 'data-published-at').to_s.should == '2013-04-01 00:00:00 UTC'
    end

    it 'converts time zones' do
      @html.search('.post-published-at').first.time(attribute: 'data-published-at', time_zone: 'America/New_York').to_s.should == '2013-04-01 04:00:00 UTC'
    end
  end

  describe '.url' do
    it 'reads absolute URLs' do
      @html.search('a.absolute-url').first.url.should == 'http://www.absoluteurl.com/'
    end

    it 'reads relative URLs' do
      @html.search('a.relative-url').first.url.should == 'http://www.loremipsum.com/p/1'
    end
  end
end