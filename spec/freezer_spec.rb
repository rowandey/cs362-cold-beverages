require_relative '../lib/freezer'

class TestFreezer < Freezer
  attr_reader :capacity, :temperature, :power, :contents
end

describe 'A freezer' do
  before do
    @freezer = TestFreezer.new
  end

  it 'can be created' do
    expect(@freezer.capacity).to eq(100)
    expect(@freezer.temperature).to eq(70)
    expect(@freezer.power).to eq(:off)
    expect(@freezer.contents).to be_empty
  end

  it 'can be turned on' do
    @freezer.turn_on

    expect(@freezer.power).to eq(:on)
  end

  it 'can be turned off' do
    @freezer.turn_on
    @freezer.turn_off

    expect(@freezer.power).to eq(:off)
  end

  it 'can have contents added' do
    item = Item.new('FAKE', 10)
    @freezer.add(item)

    expect(@freezer.contents).to eq([item])
  end

  it 'can have it\'s remaining capacity checked' do
    item1 = Item.new('FAKE1', 5)
    item2 = Item.new('FAKE2', 1)
    @freezer.add(item1)
    @freezer.add(item2)

    expect(@freezer.remaining_capacity).to eq(94)
  end

  it 'can have it\'s temperture changed' do
    @freezer.set_level(5)
    
    expect(@freezer.temperature).to eq(20)
  end
end
