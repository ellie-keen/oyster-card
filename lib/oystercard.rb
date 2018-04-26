class Oystercard

  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_LIMIT = 0
  FARE = 1

  attr_reader :balance, :journey_history, :journey

  def initialize
    @balance = DEFAULT_BALANCE
    @journey_history = []
    @journey = { entry_station: nil, exit_station: nil }
  end

  def top_up(amount)
    raise "Balance exceeds the #{MAX_LIMIT} limit." if max_limit?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Insufficent funds. Top up your card." if @balance < FARE
    @entry_station = entry_station
    @journey[:entry_station] = entry_station
  end

  def touch_out(exit_station)
    deduct
    @exit_station = exit_station
    @entry_station = nil
    @journey[:exit_station] = exit_station
    save_journey
  end

  def in_journey?
   !!@entry_station
  end

  private

  def max_limit?(amount)
    @balance + amount > MAX_LIMIT
  end

  def min_limit?
    @balance - FARE < MIN_LIMIT
  end

  def deduct
    raise 'Cannot travel. Insufficent funds.' if min_limit?
    @balance -= FARE
  end

  def save_journey
    @journey_history << @journey
  end

end
