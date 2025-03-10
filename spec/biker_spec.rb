require './lib/ride'
require './lib/biker'

RSpec.describe Biker do
  before(:each) do
    @biker = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)

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
  end
  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@biker).to be_a(Biker)
      expect(@biker.name).to eq("Kenny")
      expect(@biker.max_distance).to eq(30)
      expect(@biker.rides).to eq({})
      expect(@biker.acceptable_terrain).to eq([])
    end
  end

  describe '#learn_terrain' do
    it 'can learn new terrain' do
      @biker.learn_terrain(:gravel)
      @biker.learn_terrain(:hills)

      expect(@biker.acceptable_terrain).to eq([:gravel, :hills])
    end
  end

  describe '#log_ride' do
    it 'logs rides if terrain and distance are acceptable' do
      @biker.log_ride(ride1, 92.5)
      @biker.log_ride(ride1, 91.1)
      @biker.log_ride(ride2, 60.9)
      @biker.log_ride(ride2, 61.6)

      expected = {
        ride1 => [92.5, 91.1]
        ride2 => [60.9, 61.6]
      }

      expect(@biker.rides).to eq(expected)
    end

    it 'does not log rides if terrain is not known' do
      @biker2.log_ride(ride1, 95.0) #too long
      @biker2.log_ride(ride2, 65.0) #Should pass

      expect(biker2.rides).to eq({
        ride2 => [65.0]
      })
    end
  end
end