class Journey

attr_reader :entry_station

  def initialize(entry_station: nil)
    @entry_station = entry_station
    @complete = false
  end

  def set_entry_station(station)
    @entry_station = station
  end

  def set_exit_station(station)
    @exit_station = station
  end

  def complete?
    @complete
  end

end
