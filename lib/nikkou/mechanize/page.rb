module Nikkou
  module Mechanize
    module Page
      def self.included(base)
        base.send(:alias_method, :original_parser, :parser)
      end

      def parser
        original_parser
        @parser.uri = @uri
        @parser
      end
    end
  end
end
