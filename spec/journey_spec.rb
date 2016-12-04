require "journey"

describe Journey do

  let(:entry_station){ double(:station, zone: 1) }
  let(:exit_station){ double(:station, zone: 3) }

  context 'after starting journey' do
    before(:each) do
      subject.start(entry_station)
    end

    it 'should start a journey' do
      expect(subject.entry_station).to eq entry_station
    end

    it 'knows it\'s on a journey' do
      expect(subject).not_to be_complete
    end

    it 'should register that a journey has been completed' do
      subject.finish(exit_station)
      expect(subject).to be_complete
    end

    it 'should charge a fare for a journey' do
      subject.finish(exit_station)
      expect(subject.fare).to eq (2 + (exit_station.zone - entry_station.zone))
    end
  end

  it 'should charge penalty for not touching in' do
    subject.finish(exit_station)
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it 'returns itself when exiting the journey' do
    expect(subject.finish(exit_station)).to eq subject
  end

end
