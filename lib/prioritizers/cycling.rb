module Prioritizers
  class Cycling
    attr_reader :entries

    def initialize
      @entries = []
    end

    def add(user)
      @entries << user
    end

    def remove(user)
      @entries.delete(user)
    end

    def drop(user)
      remove(user)
      add(user)
    end

    def priority_of(user)
      entries.index(user) || (raise UnsortableElementError)
    end

    def sort(list, options = {})
      result = list.sort_by{|user| priority_of(user)}
      result.each{|element| drop(element)} if options[:confirm]
      return result
    end
  end
end

class UnsortableElementError < ArgumentError; end
