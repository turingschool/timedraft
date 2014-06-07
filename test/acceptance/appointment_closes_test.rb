require './test/test_helper'
require './lib/models/user_repository'

class AppointmentClosesTest < Minitest::Test
  attr_reader :repo, :user, :requester, :appointment

  def setup
    @repo = UserRepository.new
    @user = repo.create_user(:username => "aturing")
    @requester = repo.create_user(:username => "aturing")
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

  def test_appointment_closes_manually_with_a_single_request
    appointment.add_request_by(requester)
    appointment.close
    assert appointment.booked?
    assert_equal requester, appointment.with
  end

end
