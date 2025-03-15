require_relative '../lib/water_dispenser'

describe 'A water dispenser' do
  before do
    @reservoir = WaterReservoir.new(105, 100)
    @dispenser = WaterDispenser.new(@reservoir)
  end

  it 'can be created' do
    expect(@dispenser.reservoir).to eq(@reservoir)
  end

  it 'can be drained' do
    vessel = Vessel.new
    @dispenser.dispense(vessel)
    expect(@dispenser.reservoir.current_water_volume).to eq(0)
  end
end
