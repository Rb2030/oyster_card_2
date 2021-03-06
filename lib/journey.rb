class Journey

  attr_reader :fare, :entry_station, :exit_station

  PENALTY_FARE = 20
  MINIMUM_FARE = 3

  def initialize
    @fare = PENALTY_FARE
    @entry_station = nil
    @exit_station = nil
  end

  def in_journey?
    entry_station
  end

  def complete?
    entry_station && exit_station
  end

  def start(entry_station)
    @entry_station = entry_station
  end

  def finish(exit_station)
    @exit_station = exit_station
    @fare = zonal_fare if complete?
    self
  end

  private

  def zonal_fare
    2 + (exit_station.zone - entry_station.zone).abs
  end


end
