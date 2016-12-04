require "oystercard"
require "rspec/expectations"

describe Oystercard do

  let(:entry_station){ double(:station) }
  let(:exit_station){ double(:station) }
  let(:journey){ { entry_station: entry_station, exit_station: exit_station } }

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it 'can be topped up' do
    expect{ subject.top_up(5) }.to change{ subject.balance }.by(5)
  end

  it 'should have a maximum limit' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    subject.top_up (maximum_balance)
    expect{ subject.top_up(1) }.to raise_error "Maximum balance #{maximum_balance} exceeded"
  end

  it 'does not let a customer touch in without sufficient funds' do
    expect{ subject.touch_in(entry_station) }.to raise_error "Insufficient funds to touch in"
  end

  it 'should not deduct below 0' do
    #subject.top_up (3)
    expect{ subject.touch_in(entry_station) }.to raise_error "Insufficient funds to touch in"
  end

  context 'after topping up' do

    before(:each) do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
    end

    it 'returns the entry station when touching in' do
      expect(subject.current_journey.entry_station).to eq entry_station
    end

    it 'should deduct fare from card' do
      minimum_charge = 3
      expect { subject.touch_out(exit_station) }.to change{subject.balance}.by(-minimum_charge)
      expect(subject.balance).to eq(Oystercard::MAXIMUM_BALANCE - minimum_charge)
    end

    it 'can touch out' do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-3)
      expect(subject.current_journey).to eq nil
    end
  end
end
