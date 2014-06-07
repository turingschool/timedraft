require './test/test_helper'
require './lib/models/user_repository'

class LeaderCreatesAppointmentSlotsTest < Minitest::Test
  attr_reader :repo, :user

  def setup
    @repo = UserRepository.new
    @user = repo.create_user(:username => "aturing")
  end

  def test_leader_can_create_a_single_appointment
    assert_equal 0, user.appointments.count
    appointment = user.create_appointment(
      name: "Friday Lunch",
      starts: Time.now + 10000,
      ends: Time.now + 20000,
      recurs: :none,
      window_closes: Time.now + 250
    )
    assert_equal 1, user.appointments.count
    assert_equal "Friday Lunch", user.appointments.first.name
  end
end
