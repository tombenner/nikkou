module Nikkou
  module Nokogiri
    module XML
      module Node
        include Nikkou::Drillable
        include Nikkou::Findable

        attr_accessor :matches
        
        def attr_equals(attribute, string)
          list = []
          traverse do |node|
            list << node if node.attr(attribute) == string
          end
          ::Nokogiri::XML::NodeSet.new(document, list)
        end
        
        def attr_includes(attribute, string)
          list = []
          traverse do |node|
            next if node.attr(attribute).nil?
            list << node if node.attr(attribute).include?(string)
          end
          ::Nokogiri::XML::NodeSet.new(document, list)
        end
        
        def attr_matches(attribute, pattern)
          list = []
          traverse do |node|
            next if node.attr(attribute).nil?
            if node.attr(attribute).match(pattern)
              node.matches = $~.to_a
              list << node
            end
          end
          ::Nokogiri::XML::NodeSet.new(document, list)
        end

        def parse_text
          parse(text)
        end
        
        def text_equals(string)
          list = []
          traverse do |node|
            next if node.is_a?(::Nokogiri::XML::Text)
            list << node if node.text == string
          end
          ::Nokogiri::XML::NodeSet.new(document, list)
        end
        
        def text_includes(string)
          list = []
          traverse do |node|
            next if node.is_a?(::Nokogiri::XML::Text)
            list << node if node.text.include?(string)
          end
          ::Nokogiri::XML::NodeSet.new(document, list)
        end

        def text_matches(pattern)
          list = []
          traverse do |node|
            next if node.is_a?(::Nokogiri::XML::Text)
            if node.text.match(pattern)
              node.matches = $~.to_a
              list << node
            end
          end
          ::Nokogiri::XML::NodeSet.new(document, list)
        end

        def time(options={})
          defaults = {
            attribute: nil,
            time_zone: 'UTC' # e.g. 'Eastern Time (US & Canada)'
          }
          options.reverse_merge!(defaults)
          time_zone = TZInfo::Timezone.get(options[:time_zone])
          string = options[:attribute] ? attr(options[:attribute]).to_s : text.to_s
          if string =~ /(\d+)\s+(seconds?|minutes?|hours?|days?|weeks?|months?)\s+ago/i
            number = $1.to_i
            units = $2
            time = (Time.now.utc - number.send(units))
          else
            time = Time.zone.parse(string)
          end
          time_zone.local_to_utc(time)
        end

        def url(attribute='href')
          return nil if attr(attribute).nil?
          href = attr(attribute)
          return href if href =~ /^https?:\/\//
          return "http:#{href}" if href.start_with?('//')
          return nil if document.nil? || document.uri.nil?
          root_url = "#{document.uri.scheme}://#{document.uri.host}"
          URI.join(root_url, href).to_s
        end
      end
    end
  end
end
