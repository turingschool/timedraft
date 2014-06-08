require './test/test_helper'
require './lib/models/user_repository'
require './lib/prioritizers/arbitrary'

class AppointmentClosesTest < Minitest::Test
  attr_reader :repo, :user, :appointment, :appointment2,
              :requester, :requester2, :requester3

  def setup
    @repo = UserRepository.new
    @user = repo.create_user(:username => "aturing")
    @requester = repo.create_user(:username => "aturing")
    @requester2 = repo.create_user(:username => "jcheek")
    @requester3 = repo.create_user(:username => "jtellez")
    @appointment = user.create_appointment(
      name: "Friday Lunch"
    )
    @appointment2 = user.create_appointment(
      name: "Friday Dinner"
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
    assert_equal [requester], appointment.with
  end

  def test_appointment_closes_manually_with_fifo_request_booking
    appointment.add_request_by(requester)
    appointment.add_request_by(requester2)
    appointment.close
    assert appointment.booked?
    assert_equal [requester], appointment.with
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
    assert_equal [requester2], appointment.with
  end

  def test_appointment_closes_manually_with_cycling
    table = Prioritizers::Cycling.new
    table.add(requester)
    table.add(requester2)
    table.add(requester3)
    appointment.prioritizer = table
    appointment.add_request_by(requester3)
    appointment.add_request_by(requester)
    appointment.close
    assert appointment.booked?
    assert_equal [requester], appointment.with

    appointment2.prioritizer = table
    appointment2.add_request_by(requester3)
    appointment2.add_request_by(requester)
    appointment2.close
    assert appointment2.booked?
    assert_equal [requester3], appointment2.with
  end
end
