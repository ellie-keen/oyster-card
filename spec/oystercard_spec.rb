require 'oystercard'

describe Oystercard do
let(:oystercard) { Oystercard.new }

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

  describe ' #touch_in ' do
    it "changes in journey to true" do
      oystercard.instance_variable_set(:@balance, 20)
      oystercard.touch_in(1)
      expect(oystercard).to be_in_journey
    end

    it "deducts fare from a balance" do
      oystercard.instance_variable_set(:@balance, 20)
      expect { oystercard.touch_in(1) }.to change { oystercard.balance }.by (-1)
    end
  end

  describe ' #touch_out ' do
    it "changes in journey to false" do
      oystercard.instance_variable_set(:@balance, 20)
      oystercard.touch_in(1)
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end
  end

  describe ' #in_journey? ' do
    it "is false when card is initialized" do
      expect(oystercard).not_to be_in_journey
    end
  end
end
