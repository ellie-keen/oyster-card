describe 'Feature tests', :feature do
  let(:card) { Oystercard.new }
  let(:station) { Station.new('Oxford Circus', 1) }
  let(:station_2) { Station.new('London Bridge', 1) }
  let(:top_up_value) { 10 }


  it 'standard journey' do
    expect { card.touch_in(station) }.to raise_error("Insufficent funds. Top up your card.")
    expect { card.top_up(top_up_value) }.to change{card.balance}.by top_up_value
    card.touch_in(station)
    expect(card).to be_in_journey
    card.touch_out(station_2)
    expect(card).not_to be_in_journey
    expect(card.balance).to eq (top_up_value - Journey::FARE)
    expect(card.journey_history.count).to eq 1
    expect(card.journey_history.last.entry_station).to be station
    expect(card.journey_history.last.exit_station).to be station_2
  end

  it 'touch in, touch in' do
    card.top_up(top_up_value)
    card.touch_in(station)
    card.touch_in(station_2)
    expect(card.balance).to eq (top_up_value - Journey::PENALTY_FARE)
    expect(card).to be_in_journey
    expect(card.journey_history.count).to eq 1
    expect(card.journey_history.last.exit_station).to be_nil
  end

  it 'top up, touch out' do
    card.top_up(top_up_value)
    card.touch_out(station_2)
    expect(card.balance).to eq (top_up_value - Journey::PENALTY_FARE)
    expect(card).not_to be_in_journey
    expect(card.journey_history.count).to eq 1
    expect(card.journey_history.last.entry_station).to be_nil
    expect(card.journey_history.last.exit_station).to be station_2
  end

  it 'touch out, touch out' do
    card.top_up(top_up_value)
    card.touch_in(station)
    card.touch_out(station_2)
    card.touch_out(station)
    expect(card.balance).to eq (top_up_value - Journey::PENALTY_FARE - Journey::FARE)
    expect(card).not_to be_in_journey
    expect(card.journey_history.count).to eq 2
    expect(card.journey_history.last.entry_station).to be_nil
    expect(card.journey_history.last.exit_station).to be station
  end
end
