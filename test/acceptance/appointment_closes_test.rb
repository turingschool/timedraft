require './test/test_helper'
require './lib/models/user_repository'
require './lib/prioritizers/arbitrary'

class AppointmentClosesTest < Minitest::Test
  attr_reader :repo, :user, :requester, :requester2, :appointment

  def setup
    @repo = UserRepository.new
    @user = repo.create_user(:username => "aturing")
    @requester = repo.create_user(:username => "aturing")
    @requester2 = repo.create_user(:username => "jcheek")
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

  def test_appointment_closes_manually_with_fifo_request_booking
    appointment.add_request_by(requester)
    appointment.add_request_by(requester2)
    appointment.close
    assert appointment.booked?
    assert_equal requester, appointment.with
  end

  def test_appointment_closes_manually_with_priority_table
    priority_table = Prioritizers::Arbitrary.new
    priority_table.add(requester,  2)
    priority_table.add(requester2, 1)
    appointment.prioritizer = priority_table
    appointment.add_request_by(requester)
    appointment.add_request_by(requester2)
    appointment.close
    assert appointment.booked?
    assert_equal requester2, appointment.with
  end
end
