require 'oystercard'

describe Oystercard do
subject(:oystercard) { described_class.new }
let(:entry_station) { "Dalston Junction" }
let(:exit_station) { "Liverpool Street" }

  describe ' #initialize ' do
    it 'should have empty journeys history' do
      expect(oystercard.journey_history).to eq []
    end
    it 'should have an empty journey as default' do
      journey_init = { entry_station: nil, exit_station: nil }
      expect(oystercard.journey).to eq journey_init
    end
    it 'should initialize card with a balance of DEFAULT_BALANCE' do
      expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
    end
  end

  describe ' #top_up ' do
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
      it "records entry station in journey" do
        oystercard.instance_variable_set(:@balance, 20)
        oystercard.touch_in(entry_station)
        start_journey = { entry_station: entry_station, exit_station: nil }
        expect(oystercard.journey).to eq start_journey
      end
  end

  describe ' #touch_out ' do
    before do
      oystercard.instance_variable_set(:@balance, 20)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
    end
    it "changes in journey to false" do
        expect(oystercard).not_to be_in_journey
      end
      it "deducts fare from a balance" do
        expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by (-Oystercard::FARE)
      end
      it "records exit station in journey" do
        end_journey = { entry_station: entry_station, exit_station: exit_station }
        expect(oystercard.journey).to eq end_journey
      end
      it "saves the journey in journey history" do
        complete_journey = { entry_station: entry_station, exit_station: exit_station }
        expect(oystercard.journey_history).to include complete_journey
      end
    end


  describe "#in_journey" do
    it "returns false when exit the station" do
      oystercard.instance_variable_set(:@balance, 20)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard).not_to be_in_journey
    end
  end

end
