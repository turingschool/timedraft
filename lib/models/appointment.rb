class Appointment
  attr_reader :name, :day, :starts, :ends, :open
  attr_accessor :with

  def initialize(params)
    @name = params[:name]
    @day = params[:day]
    @starts = params[:starts]
    @ends = params[:ends]
    @open = true
  end

  def duration
    ends - starts
  end

  def open?
    open
  end

  def close
    @open = false
  end

  def closed?
    !open
  end

  def booked?

  end

end
