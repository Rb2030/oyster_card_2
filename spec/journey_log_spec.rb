require "journey_log"

describe JourneyLog do

  #let(:current_journey) {{ entry_station: entry_station, exit_station: exit_station }}

  it 'returns nil when not yet started a journey' do
    expect(subject.current_journey).to eq nil
  end

  it 'it records that the card has touched in' do
    expect(subject.journey_log).to eq current_journey
  end
end
