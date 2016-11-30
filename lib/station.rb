class Station

  attr_reader :name, :zone

  def initialize(station_details)
    @name = station_details[:name]
    @zone = station_details[:zone]
  end
end
