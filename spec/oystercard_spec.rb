require "oystercard"
require "rspec/expectations"

describe Oystercard do
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
    expect{ subject.touch_in }.to raise_error "Insufficient funds to touch in"
  end

  # describe 'topping up before (:all)' do
  #   :before(:all) do
  #     subject.top_up(Oystercard::MAXIMUM_BALANCE)
  # end
  # end


  it 'should deduct fare from card' do
    subject.top_up(50)
    minimum_charge = Oystercard::MINIMUM_CHARGE
    expect { subject.touch_out }.to change{subject.balance}.by(-minimum_charge)
    expect(subject.balance).to eq(47)
  end

  it 'should not deduct below 0' do
    expect{ subject.touch_out }.to raise_error "Insufficient funds"
  end

  it 'starts not in a journey' do
    expect(subject).not_to be_in_journey
  end

  it 'can touch in' do
    subject.top_up(50)
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'can touch out' do
    subject.top_up(50)
    subject.touch_in
    subject.touch_out
    #expect{ subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
    expect(subject).not_to be_in_journey
  end
end
