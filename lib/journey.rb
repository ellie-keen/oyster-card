class Journey

FARE = 1

attr_reader :entry_station, :exit_station, :fare

  def initialize(entry_station: nil)
    @entry_station = entry_station
    @complete = false
  end

  def set_entry_station(station)
    @entry_station = station
  end

  def complete?
    @complete
  end

  def set_complete(exit_station)
    set_exit_station(exit_station)
    @complete = true if !!@exit_station && !!@entry_station
    set_fare
  end

  private

  def set_exit_station(station)
    @exit_station = station
  end

  def set_fare
    @fare = FARE
  end

end
