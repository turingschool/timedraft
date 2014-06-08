require './test/test_helper'
require './lib/prioritizers/cycling'

class CyclingPriorizierTest < Minitest::Test
  StubUser = Struct.new(:name) do
    def inspect
      name
    end
  end

  attr_reader :table, :users

  def setup
    @table = Prioritizers::Cycling.new
    @users = [StubUser.new("a"), StubUser.new("b"), StubUser.new("c"),
              StubUser.new("d"), StubUser.new("e")]
    users.each{|u| table.add(u) }
  end

  def test_it_stores_users
    users.each_with_index do |user, index|
      assert_equal index, table.priority_of(user)
    end
  end

  def test_it_sorts_users
    input = users.shuffle
    assert_equal users, table.sort( input )
  end

  def test_it_raises_an_exception_given_an_element_not_in_the_entries
    assert_raises(UnsortableElementError) do
      table.sort( ["X"] )
    end
  end

  def test_it_cycles_a_user_to_the_bottom
    user0 = users[0]
    user1 = users[1]
    user2 = users[2]
    assert_equal [user0, user1, user2], table.sort([user1, user2, user0])
    assert_equal [user0, user1], table.sort([user1, user0], :confirm => true)
    assert_equal [user2, user0, user1], table.sort([user0, user1, user2])
  end
end
