require 'oystercard'

describe Oystercard do
let(:oystercard) { Oystercard.new }

  describe ' #balance ' do
    it 'should initialize card with a balance of 0' do
      expect(oystercard.balance).to eq 0
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
      'Balance exceeds limit.')
    end
  end

  describe ' #deduct ' do
    it 'should deduct amount from balance' do
      oystercard.instance_variable_set(:@balance, 20)
      expect { oystercard.deduct(10) }.to change { oystercard.balance }.by(-10)
    end

    it 'raises error if balance is below minimum' do
      expect { oystercard.deduct(10) }.to raise_error(RuntimeError,
      'Cannot travel. Insufficent funds.')
    end
  end
end
