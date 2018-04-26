# irb -r './spec/feature_test.rb'

require './lib/oystercard'
require './lib/journey'

def balance
  card = Oystercard.new
  p card
end

def top_up
  card = Oystercard.new
  card.top_up(10)
  p card
end

def touch_in
  card = Oystercard.new
  card.top_up(10)
  card.touch_in("Liverpool")
  p card
end

def deduct
  card = Oystercard.new
  card.top_up(10)
  card.touch_in("Liverpool")
  card.touch_out("Dalston")
  p card
end

def save_entry_station
  card = Oystercard.new
  card.top_up(10)
  card.touch_in("Liverpool")
  p card
end

def save_exit_station
  card = Oystercard.new
  card.top_up(10)
  card.touch_in("Liverpool")
  card.touch_out("Dalston")
  p card
end

def top_up_error
  card = Oystercard.new
  card.top_up(60)
  card.top_up(40)
  p card
end

def full_journey_history
  card = Oystercard.new
  card.top_up(10)
  card.touch_in("Liverpool")
  card.touch_out("Dalston")
  p card
end

def create_station
  station = Station.new
end

def touch_out_only
  card = Oystercard.new
  card.top_up(10)
  card.touch_in("Camden")
  card.touch_out("Dalston")
  card.touch_out("Waterloo")
  p card
end

#balance
#top_up
#touch_in
#deduct
#save_entry_station
#save_exit_station
#top_up_error
#full_journey_history
#create_station
#touch_out_only

def create_journey
  journey = Journey.new
  p journey
end

def default_complete_to_false
  journey = Journey.new(entry_station: "Waterloo")
  p journey.complete?
end

def save_exit_station
  journey = Journey.new(entry_station: "Waterloo")
  exit_station = "Dalston"
  journey.set_complete(exit_station)
  journey.complete?
  p journey
end

def set_fare
  journey = Journey.new(entry_station: "Waterloo")
  exit_station = "Dalston"
  # journey.set_exit_station(exit_station)
  journey.set_complete(exit_station)
  journey.complete?
  # journey.fare
end

# default_complete_to_false
save_exit_station
# set_fare
