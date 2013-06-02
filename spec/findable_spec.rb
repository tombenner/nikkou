require 'spec_helper'

describe Nikkou::Findable do
  before(:all) do
    assets_directory = File.expand_path(File.join(File.dirname(__FILE__), 'files'))
    html_file = File.join(assets_directory, 'test.html')
    @html = Nokogiri::HTML.parse(File.read(html_file))
  end

  describe Nokogiri::XML::Document do
    it 'returns nil' do
      node = @html.find('.post .post-non-existent')
      node.should be_nil
    end

    it 'returns non-nil' do
      node = @html.find('.post .post-footer')
      node.should == @html.search('.post .post-footer').first
    end
  end

  describe Nokogiri::XML::Node do
    it 'returns nil' do
      node = @html.search('body').first.find('.post .post-non-existent')
      node.should be_nil
    end

    it 'returns non-nil' do
      node = @html.search('body').first.find('.post .post-footer')
      node.should == @html.search('.post .post-footer').first
    end
  end

  describe Nokogiri::XML::NodeSet do
    it 'returns nil' do
      node = @html.search('body').find('.post .post-non-existent')
      node.should be_nil
    end

    it 'returns non-nil' do
      node = @html.search('body').find('.post .post-footer')
      node.should == @html.search('.post .post-footer').first
    end
  end
end