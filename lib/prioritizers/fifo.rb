module Prioritizers
  class FIFO
    def sort(collection)
      collection
    end

    def pull(quantity, collection)
      sort(collection)[0...quantity]
    end
  end
end
