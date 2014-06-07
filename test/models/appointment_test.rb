require './test/test_helper'
require './lib/models/appointment'

class AppointmentTest < Minitest::Test
  attr_reader :appointment

  def setup
    @appointment = Appointment.new(
      name: "Friday Lunch",
      day: :friday,
      starts: Time.now,
      ends: Time.now + 1
    )
  end

  def test_it_sets_multiple_attributes
    assert_equal "Friday Lunch", appointment.name
    assert_equal :friday, appointment.day
    assert appointment.starts
    assert appointment.ends
  end

  def test_it_calculates_duration
    marker = Time.now
    offset = 2
    app = Appointment.new(
      starts: marker,
      ends: marker + offset,
    )
    assert_equal offset, app.duration
  end

  def test_close_makes_it_closed
    assert appointment.open?
    appointment.close
    assert appointment.closed?
    refute appointment.open?
  end

  class StubUser; end

  def test_it_is_with_a_user
    target = StubUser.new
    appointment.with = target
    assert_equal target, appointment.with
  end
end
