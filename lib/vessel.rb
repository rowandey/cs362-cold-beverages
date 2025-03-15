class Vessel
  attr_reader :name, :volume

  def initialize(name = 'FAKE', volume = 100)
    @name = name
    @volume = volume
    @container = []
  end

  def empty?
    if @container.empty?
      return true
    end
  end

  def fill(input = 'TEST')
    @container = input
  end

end
