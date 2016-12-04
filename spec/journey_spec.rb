require "journey"

describe Journey do

  let(:entry_station){ double(:station, zone: 1) }
  let(:exit_station){ double(:station, zone: 3) }

  it 'should start a journey' do
    subject.start(entry_station)
    expect(subject.entry_station).to eq entry_station
  end

  it 'knows it\'s on a journey' do
    subject.start(entry_station)
    expect(subject).not_to be_complete
  end

  it 'has a penalty fare' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it 'returns itself when exiting the journey' do
    expect(subject.finish(exit_station)).to eq subject
  end

  it 'should register that a journey has been completed' do
    subject.start(entry_station)
    subject.finish(exit_station)
    expect(subject).to be_complete
  end

  it 'should charge a fare for a journey' do
    subject.start(entry_station)
    subject.finish(exit_station)
    expect(subject.fare).to eq Journey::MINIMUM_FARE
  end

  #it 'should charge for not touching in' do

end
