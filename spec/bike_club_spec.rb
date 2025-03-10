require './lib/ride'
require './lib/biker'
require './lib/bike_club'

RSpec.describe BikeClub do
  before(:each) do
    @club = BikeClub.new("Mountain Riders")
    @biker1 = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
    @biker3 = Biker.new("Andrew", 25)

    @ride1 = Ride.new({
        name: "Walnut Creek Trail",
        distance: 10.7,
        loop: false,
        terrain: :hills
      })

    @ride2 = Ride.new({
        name: "Town Lake",
        distance: 14.9,
        loop: true,
        terrain: :gravel
      })

    @biker1.learn_terrain(:hills)
    @biker1.learn_terrain(:gravel)
    @biker2.learn_terrain(:gravel)
    @biker3.learn_terrain(:hills)
    @biker3.learn_terrain(:gravel)

    @biker1.log_ride(@ride1, 92.5)
    @biker1.log_ride(@ride1, 91.1)
    @biker1.log_ride(@ride2, 60.9)
    @biker1.log_ride(@ride2, 61.6)

    @biker2.log_ride(@ride2, 65.0)

    @biker3.log_ride(@ride1, 81.3)
    @biker3.log_ride(@ride2, 50.5)
  end

  describe '#initialize' do
    it 'exists & has attributes' do
      expect(@club).to be_a(BikeClub)
      expect(@club.name).to eq("Mountain Riders")
      expect(@club.bikers).to eq([])
    end
  end

  describe '#add_biker' do
    it 'can add bikers' do
      @club.add_biker(@biker1)
      @club.add_biker(@biker2)
      @club.add_biker(@biker3)

      expect(@club.bikers).to eq([@biker1, @biker2, @biker3])
    end
  end

  describe '#most_rides' do
    it 'can determine which biker has logges the most rides' do
      @club.add_biker(@biker1)
      @club.add_biker(@biker2)
      @club.add_biker(@biker3)

      expect(@club.most_rides).to eq(@biker1)
    end
  end

  describe '#best_time' do
    it 'can determine which biker has the best time for a given ride' do
      @club.add_biker(@biker1)
      @club.add_biker(@biker2)
      @club.add_biker(@biker3)

      expect(@club.best_time(@ride1)).to eq(@biker3)
      expect(@club.best_time(@ride2)).to eq(@biker3)
    end
  end

  describe '#bikers_eligible' do
    it 'can determine which bikers are eligible for a given ride' do
      @club.add_biker(@biker1)
      @club.add_biker(@biker2)
      @club.add_biker(@biker3)

      expect(@club.bikers_eligible(@ride1)).to eq([@biker1, @biker3])
      expect(@club.bikers_eligible(@ride2)).to eq([@biker1, @biker2, @biker3])
    end
  end
end