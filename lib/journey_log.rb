class JourneyLog

  attr_reader :journey_log, :current_journey

  def initialize
    @journey_log = []
    @current_journey = nil
  end

  def touch_in(station)
    @current_journey = Journey.new
    journey_log << @current_journey
  end




end
