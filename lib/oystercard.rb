class Oystercard

  attr_reader :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 3

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
    deduct(MINIMUM_CHARGE)
    fail "Insufficient funds" if balance < 0
    @travelling = false
  end

private

  def deduct(amount)
    @balance -= amount
  end
end
