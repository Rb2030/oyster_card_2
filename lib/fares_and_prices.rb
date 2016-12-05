class FaresAndPrices

  def initialize
  end

  def zonal_fare
    2 + (exit_station.zone - entry_station.zone).abs
  end
  
end
