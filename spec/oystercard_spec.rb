require 'oystercard'

describe Oystercard do
  let(:oystercard) { Oystercard.new }

  describe ' #balance ' do
    it 'should return the balance' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe ' #top_up ' do
    it 'should respond to top_up method' do
      expect(oystercard).to respond_to(:top_up).with(1).argument
    end

    it 'should return correct balance when topped up' do
      expect { oystercard.top_up(10) }.to change { oystercard.balance }.by(10)
    end

    it 'should raise error if total exceeds max limit' do
      expect { oystercard.top_up(100) }.to raise_error(RuntimeError,
        'Balance exceeds limit.')
    end
  end

  describe ' #deduct ' do
    it 'should deduct an amount from our balance and return correct amount' do
      oystercard.instance_variable_set(:@balance, 20)
      expect { oystercard.deduct(10) }.to change { oystercard.balance }.by(-10)
    end

    it 'should raise error if balance is below 0' do
      expect { oystercard.deduct(10) }.to raise_error(RuntimeError,
        'Cannot travel. Insufficent funds.')
    end
end
end
