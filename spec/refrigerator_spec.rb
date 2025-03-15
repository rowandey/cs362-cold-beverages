require_relative '../lib/refrigerator'

class TestRefrigerator < Refrigerator
  attr_reader :chiller, :freezer, :control_panel, :water_dispenser, :water_reservoir, :power
end

describe 'A refrigerator' do
  before do
    @chiller = TestChiller.new
    @freezer = TestFreezer.new
    @reservoir = WaterReservoir.new
    @dispenser = WaterDispenser.new(@reservoir)

    @refrigerator = TestRefrigerator.new(@chiller, @freezer, @dispenser, @reservoir)
  end

  it 'can be created' do
    expect(@refrigerator.chiller).to eq(@chiller)
    expect(@refrigerator.freezer).to eq(@freezer)
    expect(@refrigerator.water_dispenser).to eq(@dispenser)
    expect(@refrigerator.water_reservoir).to eq(@reservoir)
    expect(@refrigerator.power).to eq(:off)
  end

  it 'can chill items' do
    item = Item.new('FAKE', 10)
    @refrigerator.chill(item)
    expect(@refrigerator.chiller.contents).to eq([item])
  end

  it 'can freeze items' do
    item = Item.new('FAKE', 10)
    @refrigerator.freeze(item)
    expect(@refrigerator.freezer.contents).to eq([item])
  end

  it 'can get total capacity' do
    # could maybe make these user @freezer.capacity + @chiller.capacity
    # not sure if that is really better though due to it being less explicit
    expect(@refrigerator.total_capacity).to eq(200) 
  end

  it 'can get total remaining capacity' do
    item = Item.new('FAKE', 10)
    @refrigerator.freeze(item)
    expect(@refrigerator.remaining_capacity).to eq(190)

    item2 = Item.new('FAKE', 40)
    @refrigerator.chill(item2)
    expect(@refrigerator.remaining_capacity).to eq(150)
  end

  it 'can be turned on' do
    @refrigerator.plug_in
    expect(@refrigerator.power).to eq(:on)
    expect(@freezer.power).to eq(:on)
    expect(@chiller.power).to eq(:on)
  end

  it 'can be turned off' do
    @refrigerator.plug_in
    @refrigerator.unplug
    expect(@refrigerator.power).to eq(:off)
    expect(@freezer.power).to eq(:off)
    expect(@chiller.power).to eq(:off)
  end

  it 'can change chiller level' do
    @refrigerator.set_chiller_level(5)
    expect(@chiller.temperature).to eq(45)
  end

  it 'can change freezer level' do
    @refrigerator.set_freezer_level(5)
    expect(@freezer.temperature).to eq(20)
  end


  it 'returns it\'s status' do
    expected_output = <<~STATUS
      Power: off
      Storage: 200 of 200 available
      Temps: Chiller is 70, Freezer is 70
      Water: Reservoir has 0 remaining.
    STATUS

    expect(@refrigerator.to_s).to eq(expected_output)

    allow(@chiller).to receive(:temperature).and_return(45)
    allow(@freezer).to receive(:temperature).and_return(20)
    allow(@refrigerator).to receive(:remaining_capacity).and_return(5)

    second_expected_output = <<~STATUS
      Power: off
      Storage: 5 of 200 available
      Temps: Chiller is 45, Freezer is 20
      Water: Reservoir has 0 remaining.
    STATUS

    expect(@refrigerator.to_s).to eq(second_expected_output)
  end
end
