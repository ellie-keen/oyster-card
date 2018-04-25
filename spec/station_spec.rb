require 'station'

describe Station do
  let (:name) { double :name }
  let (:zone) { double :zone }
  subject(:station) { described_class.new(name, zone) }


  describe '#initilize' do
    it 'should have a name' do
      expect(station.name).to eq name
    end
    it 'should have zone' do
      expect(station.zone).to eq zone
    end
  end


end
