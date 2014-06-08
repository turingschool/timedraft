module Prioritizers
  class Cycling
    attr_reader :entries

    def initialize
      @entries = []
    end

    def add(user)
      @entries << user
    end

    def priority_of(user)
      entries.index(user) || (raise UnsortableElementError)
    end

    def sort(list)
      result = list.sort_by{|user| priority_of(user)}
      return result
    end
  end
end

class UnsortableElementError < ArgumentError; end
