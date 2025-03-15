require_relative '../lib/water_reservoir'

class TestWaterReservoir < WaterReservoir
  def fill
    @current_water_volume = capacity
  end
end

describe 'A water reservoir' do
  before do
    @reservoir = TestWaterReservoir.new
  end

  it 'can be created' do
    expect(@reservoir.capacity).to eq(10)
    expect(@reservoir.current_water_volume).to eq(0)
  end

  it 'is empty?' do
    expect(@reservoir).to be_empty
  end

  it 'can be filled' do
    @reservoir.fill()
    expect(@reservoir.current_water_volume).to eq(10)
  end

  it 'can be drained' do
    @reservoir.fill()
    @reservoir.drain(5)
    expect(@reservoir.current_water_volume).to eq(5)
  end

end
