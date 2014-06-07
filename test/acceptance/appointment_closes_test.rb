require './test/test_helper'
require './lib/models/user_repository'

class AppointmentClosesTest < Minitest::Test
  attr_reader :repo, :user, :appointment

  def setup
    @repo = UserRepository.new
    @user = repo.create_user(:username => "aturing")
    @appointment = user.create_appointment(
      name: "Friday Lunch"
    )
  end

  def test_appointment_closes_manually_without_requests
    assert appointment.open?
    appointment.close
    assert appointment.closed?
    refute appointment.with
    refute appointment.booked?
  end

end
