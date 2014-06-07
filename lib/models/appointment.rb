class Appointment
  attr_reader :name, :day, :starts, :ends

  def initialize(params)
    @name = params[:name]
    @day = params[:day]
    @starts = params[:starts]
    @ends = params[:ends]
  end

end
