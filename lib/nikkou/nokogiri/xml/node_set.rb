module Nikkou
  module Nokogiri
    module XML
      module NodeSet
        include Nikkou::Drillable
        include Nikkou::Findable
        
        def attr_equals(attribute, string)
          list = select do |node|
            return false if node.attr(attribute).nil?
            node.attr(attribute) == string
          end
          self.class.new(document, list)
        end
        
        def attr_includes(attribute, string)
          list = select do |node|
            return false if node.attr(attribute).nil?
            node.attr(attribute).include?(string)
          end
          self.class.new(document, list)
        end
        
        def attr_matches(attribute, pattern)
          list = []
          each do |node|
            next if node.attr(attribute).nil?
            if node.attr(attribute).match(pattern)
              node.matches = $~.to_a
              list << node
            end
          end
          self.class.new(document, list)
        end
        
        def text_equals(string)
          list = select do |node|
            next if node.is_a?(::Nokogiri::XML::Text)
            node.text == string
          end
          self.class.new(document, list)
        end
        
        def text_includes(string)
          list = select do |node|
            next if node.is_a?(::Nokogiri::XML::Text)
            node.text.include?(string)
          end
          self.class.new(document, list)
        end

        def text_matches(pattern)
          list = []
          each do |node|
            next if node.is_a?(::Nokogiri::XML::Text)
            if node.text.match(pattern)
              node.matches = $~.to_a
              list << node
            end
          end
          self.class.new(document, list)
        end
      end
    end
  end
end
