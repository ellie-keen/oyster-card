require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:amount) { 5 }
  let(:entry_station) { "Dalston Junction" }
  let(:exit_station) { "Liverpool Street" }
  let(:journey) { double :journey }

  it 'oystercard balance is initialized with a value of DEFAULT_BALANCE' do
    expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
  end
  it 'should have empty journey_history when initialized' do
    expect(oystercard.journey_history).to eq []
  end

  describe ' #top_up ' do
    it 'should add the amount to the balance' do
      expect { oystercard.top_up(amount) }.to change { oystercard.balance }.by(amount)
    end
    it 'raises error if amount to be added exceeds the maximum limit' do
      expect { oystercard.top_up(100) }.to raise_error(RuntimeError,
      "Balance exceeds the #{Oystercard::MAX_LIMIT} limit.")
    end
  end

  describe ' #touch_in ' do
    it 'records entry station in journey' do
      oystercard.instance_variable_set(:@balance, amount)
      oystercard.touch_in(entry_station)
      expect(oystercard.journey.entry_station).to eq entry_station
    end
    it 'raises an error if there is not enough money on card' do
      expect { oystercard.touch_in(entry_station) }.to raise_error(RuntimeError,
         'Insufficent funds. Top up your card.')
    end
  end

  describe ' #touch_out ' do
    it "deducts fare from a balance" do
      oystercard.instance_variable_set(:@balance, amount) # replace with top up
      oystercard.touch_in(entry_station)
      expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by (-Oystercard::FARE)
    end
    it 'raises an error' do
      expect { oystercard.touch_out(exit_station) }.to raise_error(RuntimeError,
        'Cannot travel. Insufficent funds.')
    end
  end

  context 'complete journey' do

    before do
      oystercard.instance_variable_set(:@balance, amount) # replace with top up
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
    end
    it 'sets journey.complete to true' do
      expect(oystercard.journey).to be_complete
    end
    it 'saves the complete journey in journey_history' do
      expect(oystercard.journey_history.length).to eq 1
    end
  end

  context ' touch in, touch in '
    before do
      oystercard.top_up(amount)
      oystercard.touch_in(entry_station)
      oystercard.touch_in(exit_station)
    end

    it "should deduct penalty fare from balance" do
      expect(oystercard.balance).to eq (amount - PENALTY_FARE)
    end
end
