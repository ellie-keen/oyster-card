require 'journey'

describe Journey do

  let(:entry_station) { "Waterloo" }
  let(:journey) { Journey.new }
  let(:journey_with_entry) { Journey.new(entry_station: entry_station) }

  describe ' #initialize ' do

    it "returns default when no entry station is passed" do
      expect(journey.entry_station).to be_nil
    end

    it "returns entry station when passed an entry station" do
      expect(journey_with_entry.entry_station).to be entry_station
    end

    it "complete is initialized with the value false" do
      expect(journey_with_entry.complete?).to eq false
    end

  end


  describe ' #set_entry_station ' do

    it 'should return correct entry station' do
      expect(journey.set_entry_station(entry_station)).to eq entry_station
    end
  end

end
