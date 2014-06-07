gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

class Minitest::Test
  def assert_count(expected, collection)
    assert_equal expected, collection.count
  end
end
