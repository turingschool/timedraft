require './test/test_helper'
require './lib/models/user_repository'

class UserRepositoryTest < Minitest::Test
  attr_reader :repo

  def setup
    @repo = UserRepository.new
    repo.create_user(:username => "aturing")
  end

  def test_login_as_a_specific_user
    user = repo.login_as("aturing")
    assert_equal "aturing", user.username
  end

  def test_login_as_a_user_is_always_the_same_user
    user1 = repo.login_as("aturing")
    user2 = repo.login_as("aturing")
    assert_equal user1, user2
  end

end
