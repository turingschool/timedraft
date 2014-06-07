require './lib/models/request'

class Appointment
  attr_reader :name, :day, :starts, :ends, :open, :requests
  attr_accessor :with

  def initialize(params)
    @name = params[:name]
    @day = params[:day]
    @starts = params[:starts]
    @ends = params[:ends]
    @open = true
    @requests = []
  end

  def duration
    ends - starts
  end

  def open?
    open
  end

  def close
    @open = false
    @booked = true if (with || resolve_requests)
  end

  def closed?
    !open
  end

  def booked?
    @booked
  end

  def add_request_by(user)
    request = Request.new(user)
    requests << request
    request
  end

  def resolve_requests
    if requests.any?
      self.with = requests.first.user
    end
  end

end
