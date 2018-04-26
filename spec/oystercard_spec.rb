require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:amount) { 5 }
  let(:entry_station) { "Dalston Junction" }
  let(:exit_station) { "Liverpool Street" }

  it 'oystercard balance is initialized with a value of DEFAULT_BALANCE' do
    expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
  end
  it 'should have empty journey_history when initialized' do
    expect(oystercard.journey_history).to eq []
  end
  it 'should have an empty journey when initialized' do
    # pending('requires adding journey class')
    journey = { entry_station: nil, exit_station: nil }
    expect(oystercard.journey).to eq journey
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
    it 'changes in journey to true' do
      oystercard.instance_variable_set(:@balance, amount)
      oystercard.touch_in(entry_station)
      expect(oystercard).to be_in_journey
    end
    it 'records entry station in journey' do
      oystercard.instance_variable_set(:@balance, amount)
      oystercard.touch_in(entry_station)
      journey_after_touch_in = { entry_station: entry_station, exit_station: nil }
      expect(oystercard.journey).to eq journey_after_touch_in
    end
    it 'raises an error if there is not enough money on card' do
      expect { oystercard.touch_in(entry_station) }.to raise_error(RuntimeError,
         'Insufficent funds. Top up your card.')
    end
  end

  describe ' #touch_out ' do
    it "deducts fare from a balance" do
      oystercard.instance_variable_set(:@balance, amount)
      oystercard.touch_in(entry_station)
      expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by (-Oystercard::FARE)
    end
    it 'raises an error' do
      expect { oystercard.touch_out(exit_station) }.to raise_error(RuntimeError,
        'Cannot travel. Insufficent funds.')
    end
  end

  describe ' #in_journey? ' do
    it 'returns true when in journey' do
      oystercard.instance_variable_set(:@balance, amount)
      oystercard.touch_in(entry_station)
      expect(oystercard).to be_in_journey
    end
    it 'returns false when not in journey' do
      expect(oystercard).not_to be_in_journey
    end
  end

  context 'complete journey' do
    let(:complete_journey) { { entry_station: entry_station, exit_station: exit_station } }

    before do
      oystercard.instance_variable_set(:@balance, amount)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
    end
    it 'changes in_journey from true to false' do
      expect(oystercard).not_to be_in_journey
    end
    it 'records exit station and entry station in journey' do
      expect(oystercard.journey).to eq complete_journey
    end
    it 'saves the complete journey in journey_history' do
      expect(oystercard.journey_history).to include complete_journey
    end
  end
end
