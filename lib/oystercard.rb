class Oystercard

  MAX_LIMIT = 90
  MIN_LIMIT = 0
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Cannot top up as balance exceeds maximum limit." if max_limit?(amount)
    "Your total balance is £#{@balance += amount}."
  end

  def deduct(amount)
    raise "Cannot travel. Insufficent funds." if min_limit?(amount)
    "Your total balance is £#{@balance -= amount}"
  end

private

  def max_limit?(amount)
    @balance + amount > MAX_LIMIT
  end

  def min_limit?(amount)
    @balance - amount < MIN_LIMIT
  end

end
