class Oystercard
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_LIMIT = 0
  FARE = 1
  attr_reader :balance, :entry_station

  def initialize
    @balance = DEFAULT_BALANCE
  #  @in_journey = false
  end

  def top_up(amount)
    raise "Balance exceeds the #{MAX_LIMIT} limit." if max_limit?(amount)
    total = @balance += amount
    "Your total balance is: £#{total}" #test this line
  end

  def touch_in(entry_station)
    raise "Insufficent funds. Top up your card." if @balance < FARE
    @entry_station = entry_station
  end

  def touch_out(fare)
    deduct(fare)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  private

  def max_limit?(amount)
    @balance + amount > MAX_LIMIT
  end

  def min_limit?(amount)
    @balance - amount < MIN_LIMIT
  end

  def deduct(amount)
    raise 'Cannot travel. Insufficent funds.' if min_limit?(amount)
    total = @balance -= amount
    "Your total balance is: £#{total}" #test this line
  end

end
