class Oystercard

  attr_reader :balance, :entry_station, :journey_log

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 3

  def initialize
    @balance = 0
    @entry_station = nil
    @journey_log = []
  end

  def top_up(amount)
    fail "Maximum balance #{MAXIMUM_BALANCE} exceeded" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    fail "Insufficient funds" if @balance - amount < 0
    @balance -= amount
  end

  def in_journey?
    entry_station
  end

  def touch_in(station)
    fail "Insufficient funds to touch in" if balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    fail "Insufficient funds" if zero_balance?
    journey_log << { entry_station: entry_station, exit_station: station }
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def zero_balance?
    balance < 0
  end
end
