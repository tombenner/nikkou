module Nikkou
  module Findable
    def find(*paths)
      search(*paths).first
    end
  end
end