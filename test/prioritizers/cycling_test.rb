require './test/test_helper'
require './lib/prioritizers/cycling'

class CyclingPriorizierTest < Minitest::Test
  class StubUser; end

  attr_reader :table, :users

  def setup
    @table = Prioritizers::Cycling.new
    @users = [StubUser.new, StubUser.new, StubUser.new, StubUser.new, StubUser.new]
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

  # def test_it_cycles_a_user_to_the_bottom
  #   target = users.first
  #   table.sort()
  # end
end
