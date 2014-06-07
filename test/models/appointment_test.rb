require './test/test_helper'
require './lib/models/appointment'

class AppointmentTest < Minitest::Test
  def test_it_sets_multiple_attributes
    appointment = Appointment.new(
      name: "Friday Lunch",
      day: :friday,
      starts: "12:00",
      ends: "13:00",
      recurs: :none,
      window_closes: "3 days"
    )

    assert_equal "Friday Lunch", appointment.name
    assert_equal :friday, appointment.day
    assert_equal "12:00", appointment.starts
    assert_equal "13:00", appointment.ends
  end
end
