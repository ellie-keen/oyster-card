# irb -r './spec/feature_test.rb'

require './lib/oystercard'

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

#balance
#top_up
#touch_in
#deduct
#save_entry_station
#save_exit_station

#top_up_error

full_journey_history

# irb -r './spec/feature_test.rb'
