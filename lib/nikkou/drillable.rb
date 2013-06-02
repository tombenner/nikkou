module Nikkou
  module Drillable
    def drill(*methods)
      value = self
      methods.each do |method|
        if method.is_a?(Array)
          value = value.send(*method)
        else
          value = value.send(method)
        end
        return nil if value.blank?
      end
      value
    end
  end
end