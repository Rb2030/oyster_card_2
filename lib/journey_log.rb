class JourneyLog

  attr_reader :current_journey

  def initialize
    @journey_log = []
    @current_journey = nil
  end

  def touch_in(entry_station)
    @current_journey = entry_station
  end




end
