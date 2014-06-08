module Prioritizers
  class Arbitrary
    attr_reader :entries

    def initialize
      @entries = []
    end

    def add(user, priority)
      @entries << [user, priority]
    end

    def priority_of(target)
      entries.detect{|user, priority| user == target}.last
    end

    def sort(collection)
      collection.sort_by{|element| priority_of(element)}
    end
  end
end
