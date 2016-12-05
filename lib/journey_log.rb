class JourneyLog

  attr_reader :journey_log, :current_journey, :entry_station

  def initialize
    @journey_log = []
    @current_journey = nil
    @entry_station = nil
  end

  def touch_in(entry_station)
    @current_journey = Journey.new
    @entry_station = entry_station
    @journey_log << entry_station
  end




end
