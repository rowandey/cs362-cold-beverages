class WaterReservoir

  attr_reader :capacity
  attr_accessor :current_water_volume

  def initialize(capacity = 10, initial_water_volume = 0)
    @capacity = capacity
    @current_water_volume = initial_water_volume
  end

  def empty?
    current_water_volume == 0
  end

  def fill(volume)
    old_water_volume = @current_water_volume
    @current_water_volume += volume

    if @current_water_volume > @capacity
      puts 'Reservoir full! Cannot be filled further.'
      @current_water_volume = capacity
    end
  end

  def drain(volume)
    self.current_water_volume -= volume

    # prevent negatives
    if @current_water_volume < 0
      @current_water_volume = 0
    end
  end

end
