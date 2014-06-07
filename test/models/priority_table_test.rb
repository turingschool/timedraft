require './test/test_helper'
require './lib/models/priority_table'

class PriorityTableTest < Minitest::Test
  class StubUser; end

  def test_it_stores_priority_entries
    table = PriorityTable.new
    user1 = StubUser.new
    user2 = StubUser.new
    table.add(user1, 5)
    table.add(user2, 10)
    assert_count 2, table.entries
    assert_equal 5, table.priority_of(user1)
    assert_equal 10, table.priority_of(user2)
  end

  def test_it_prioritizes_a_collection
    table = PriorityTable.new
    user1 = StubUser.new
    user2 = StubUser.new
    user3 = StubUser.new
    table.add(user3, 5)
    table.add(user1, 10)
    table.add(user2, 15)
    assert_equal [user3, user1, user2], table.sort( [user1, user2, user3] )
  end
end
