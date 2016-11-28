require "oystercard"

describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  it 'can be topped up' do
    expect{ subject.top_up(5) }.to change{ subject.balance }.by(5)
  end

  it 'should hava a maximum limit' do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    subject.top_up (maximum_balance)
    expect{ subject.top_up(1) }.to raise_error "Maximum balance #{maximum_balance} exceeded"
  end

  it 'should deduct fare from card' do
    subject.top_up(50)
    subject.deduct(10)

    expect(subject.balance).to eq(40)
  end

  it 'should not deduct below 0' do
    expect{ subject.deduct(1) }.to raise_error "Insufficient funds"
  end
end
