require './lib/models/request'
require './lib/models/fifo_table'

class Appointment
  attr_reader :name, :day, :starts, :ends, :open, :requests
  attr_accessor :with, :prioritizer

  def initialize(params)
    @name = params[:name]
    @day = params[:day]
    @starts = params[:starts]
    @ends = params[:ends]
    @open = true
    @requests = []
    @prioritizer = params[:prioritizer] || FIFOTable.new
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
      users = requests.map(&:user)
      self.with = prioritizer.sort(users).first
    end
  end

end
