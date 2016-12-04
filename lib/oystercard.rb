class Oystercard

  attr_reader :balance, :journey_log, :current_journey

  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
    @journey_log = []
    @current_journey = nil
  end

  def top_up(amount)
    fail "Maximum balance #{MAXIMUM_BALANCE} exceeded" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    fail "Insufficient funds" if @balance - amount < 0
    @balance -= amount
  end

  def touch_in(station)
    fail "Insufficient funds to touch in" if balance < Journey::MINIMUM_FARE
    @current_journey = Journey.new
    @current_journey.start(station)
  end

  def touch_out(station)
    @current_journey.finish(station)
    fail "Insufficient funds" if balance < @current_journey.fare
    deduct(@current_journey.fare)
    journey_log << @current_journey
    @current_journey = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def zero_balance?
    balance < 0
  end
end
