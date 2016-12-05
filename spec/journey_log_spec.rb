require "journey_log"

describe JourneyLog do

  let(:journey) { double(:journey, entry_station: entry_station, exit_station: exit_station) }
  let(:entry_station) { double(:entry_station, name: "Old Street", zone: 1) }
  let(:exit_station) { double(:exit_station, name: "Cannon Street", zone: 3) }

  it 'should be empty if there are no journeys' do
    expect(subject.journeys).to eq []
  end

  it 'should add the journey into the log' do
    subject.add(journey)
    expect(subject.journeys).to include journey
  end

end
