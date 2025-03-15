class WaterDispenser

  attr_reader :reservoir

  def initialize(reservoir)
    @reservoir = reservoir
  end

  def dispense(vessel)
    reservoir.drain(vessel.volume)
  end

  def fill_reservoir(vessel)
    reservoir.fill(vessel.volume)
  end

end
