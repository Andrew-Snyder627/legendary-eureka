class BikeClub
  attr_reader :name, :bikers

  def initialize(name)
    @name = name
    @bikers = []
  end

  def add_biker(biker)
    @bikers << biker
  end

  def most_rides
    @bikers.max_by do |biker|
      biker.rides.values.sum do |times|
        times.count
      end
    end
  end

  def best_time(ride)
    bikers_with_ride = @bikers.select do |biker|
      biker.rides.key?(ride)
    end

    bikers_with_ride.min_by do |biker|
      biker.personal_record(ride)
    end
  end

  def bikers_eligible(ride)
    
  end
end