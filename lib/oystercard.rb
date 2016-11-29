class Oystercard

  attr_reader :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
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
    @travelling
  end

  def touch_in
    fail "Insufficient funds to touch in" if balance < MINIMUM_BALANCE
    @travelling = true
  end

  def touch_out
    @travelling = false
  end
end
