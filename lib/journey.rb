class Journey

attr_reader :entry_station

  def initialize(entry_station: nil)
    @entry_station = entry_station
  end

  def set_entry_station(station)
    @entry_station = station
  end

end
