require 'spec_helper'

describe Nikkou::Drillable do
  before(:all) do
    assets_directory = File.expand_path(File.join(File.dirname(__FILE__), 'files'))
    html_file = File.join(assets_directory, 'test.html')
    @html = Nokogiri::HTML.parse(File.read(html_file))
  end

  describe Nokogiri::XML::Document do
    it 'returns nil' do
      nodes = @html.drill([:search, '.post'], :first, [:search, '.post-non-existent'])
      nodes.should be_nil
    end

    it 'returns non-nil' do
      nodes = @html.drill([:search, '.post'], :first, [:search, '.post-footer'])
      nodes.should == @html.search('.post').first.search('.post-footer')
    end
  end

  describe Nokogiri::XML::Node do
    it 'returns nil' do
      nodes = @html.search('body').first.drill([:search, '.post'], :first, [:search, '.post-non-existent'])
      nodes.should be_nil
    end

    it 'returns non-nil' do
      nodes = @html.search('body').first.drill([:search, '.post'], :first, [:search, '.post-footer'])
      nodes.should == @html.search('.post').first.search('.post-footer')
    end
  end

  describe Nokogiri::XML::NodeSet do
    it 'returns nil' do
      nodes = @html.search('body').drill([:search, '.post'], :first, [:search, '.post-non-existent'])
      nodes.should be_nil
    end

    it 'returns non-nil' do
      nodes = @html.search('body').drill([:search, '.post'], :first, [:search, '.post-footer'])
      nodes.should == @html.search('.post').first.search('.post-footer')
    end
  end
end