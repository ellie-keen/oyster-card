class Oystercard
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_LIMIT = 0
  FARE = 1
  attr_reader :balance

  def initialize
    @balance = DEFAULT_BALANCE
    @in_journey = false
  end

  def top_up(amount)
    raise "Balance exceeds the #{MAX_LIMIT} limit." if max_limit?(amount)
    total = @balance += amount
    "Your total balance is: £#{total}" #test this line
  end

  def deduct(amount)
    raise 'Cannot travel. Insufficent funds.' if min_limit?(amount)
    total = @balance -= amount
    "Your total balance is: £#{total}" #test this line
  end

  def touch_in(fare)
    deduct(FARE)
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def max_limit?(amount)
    @balance + amount > MAX_LIMIT
  end

  def min_limit?(amount)
    @balance - amount < MIN_LIMIT
  end

end
