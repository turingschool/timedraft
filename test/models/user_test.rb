require './test/test_helper'
require './lib/models/user'

class UserTest < Minitest::Test
  def test_it_exists
    assert User
  end

  def test_it_stores_a_username
    user = User.new(username: "aturing")
    assert_equal "aturing", user.username
  end

  def test_users_are_equated_by_their_id
    user1 = User.new(:username => "aturing", :id => 1)
    user2 = User.new(:username => "aturing", :id => 1)
    assert_equal user1, user2
  end

  def test_users_generate_an_id
    refute User.new(:username => "aturing").id.nil?
  end
end
