class Ride
  attr_reader :name, :distance, :terrain

  def initialize(details)
    @name = details[:name]
    @distance = details[:distance]
    @loop = details[:loop]
    @terrain = details[:terrain]
  end

  def loop?
    @loop
  end

  def total_distance
    if loop?
      @distance
    else
      @distance * 2
    end
  end
end