require_relative '../lib/chiller'

class TestChiller < Chiller
  attr_reader :capacity, :temperature, :power, :contents
end

describe 'A chiller' do
  before do
    @chiller = TestChiller.new
  end

  it 'can be created' do
    expect(@chiller.capacity).to eq(100)
    expect(@chiller.temperature).to eq(70)
    expect(@chiller.power).to eq(:off)
    expect(@chiller.contents).to be_empty
  end

  it 'can be turned on' do
    @chiller.turn_on

    expect(@chiller.power).to eq(:on)
  end

  it 'can be turned off' do
    @chiller.turn_on
    @chiller.turn_off

    expect(@chiller.power).to eq(:off)
  end

  it 'can have contents added' do
    item = Item.new('FAKE', 10)
    @chiller.add(item)

    expect(@chiller.contents).to eq([item])
  end

  it 'can have it\'s remaining capacity checked' do
    item1 = Item.new('FAKE1', 5)
    item2 = Item.new('FAKE2', 1)
    @chiller.add(item1)
    @chiller.add(item2)

    expect(@chiller.remaining_capacity).to eq(94)
  end

  it 'can have it\'s temperture changed' do
    @chiller.set_level(5)
    
    expect(@chiller.temperature).to eq(45)
  end
end
