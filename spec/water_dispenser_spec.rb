require_relative '../lib/water_dispenser'

describe 'A water dispenser' do
  before do
    @reservoir = WaterReservoir.new(120)
    @dispenser = WaterDispenser.new(@reservoir)
    @vessel = Vessel.new
  end

  it 'can be created' do
    expect(@dispenser.reservoir).to eq(@reservoir)
  end

  it 'can be drained' do
    
    @dispenser.dispense(@vessel)
    expect(@dispenser.reservoir.current_water_volume).to eq(0)
  end

  it 'can be filled' do
    @dispenser.fill_reservoir(@vessel)
    expect(@dispenser.reservoir.current_water_volume).to eq(100)
  end

  it 'can handle overflow' do
    @reservoir = WaterReservoir.new(50)
    @dispenser = WaterDispenser.new(@reservoir)

    expect {@dispenser.fill_reservoir(@vessel)}.to output("Reservoir full! Cannot be filled further.\n").to_stdout
    expect(@dispenser.reservoir.current_water_volume).to eq(50)
  end
end
