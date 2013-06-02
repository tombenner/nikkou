module Nikkou
  module Nokogiri
    module XML
      module Document
        attr_accessor :uri

        def uri=(uri)
          uri = URI(uri) if uri.is_a?(String)
          @uri = uri
        end
      end
    end
  end
end