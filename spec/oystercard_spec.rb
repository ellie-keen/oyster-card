require 'oystercard'

describe Oystercard do
subject(:oystercard) { described_class.new }
let(:entry_station) { "entry_station" }

  describe ' #balance ' do
    it 'should initialize card with a balance of 0' do
      expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
    end
  end

  describe ' #top_up ' do
    it 'should take an amount as an argument' do
      expect(oystercard).to respond_to(:top_up).with(1).argument
    end

    it 'should add the amount to the balance' do
      expect { oystercard.top_up(10) }.to change { oystercard.balance }.by(10)
    end

    it 'raises error if it exceeds the maximum limit' do
      expect { oystercard.top_up(100) }.to raise_error(RuntimeError,
      "Balance exceeds the #{Oystercard::MAX_LIMIT} limit.")
    end
  end

  describe ' #touch_in ' do
    it "changes in journey to true" do
      oystercard.instance_variable_set(:@balance, 20)
      oystercard.touch_in(entry_station)
      expect(oystercard).to be_in_journey
    end

    it "raises an error if not enough money on card" do
      expect { oystercard.touch_in(entry_station) }.to raise_error(RuntimeError,
         "Insufficent funds. Top up your card.")
    end

    it "remembers the entry staton" do
      oystercard.instance_variable_set(:@balance, 20)
      oystercard.touch_in(entry_station)
      expect(oystercard.entry_station).to eq(entry_station)
    end
  end

  describe ' #touch_out ' do
    it "changes in journey to false" do
      oystercard.instance_variable_set(:@balance, 20)
      oystercard.touch_out(Oystercard::FARE)
      expect(oystercard).not_to be_in_journey
    end

    it "deducts fare from a balance" do
      oystercard.instance_variable_set(:@balance, 20)
      expect { oystercard.touch_out(Oystercard::FARE) }.to change { oystercard.balance }.by (-Oystercard::FARE)
    end

    it "sets entry_station to nil" do
      oystercard.instance_variable_set(:@balance, 20)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(Oystercard::FARE)
      expect(oystercard.entry_station).to eq(nil)
    end
  end

  describe ' #in_journey? ' do
    it "is false when card is initialized" do
      expect(oystercard).not_to be_in_journey
    end

    it "returns true when entry station exists" do
      oystercard.instance_variable_set(:@balance, 20)
      oystercard.touch_in(entry_station)
      expect(oystercard).to be_in_journey
    end

  end
end
