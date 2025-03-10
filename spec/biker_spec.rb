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
    it 'exists & has attributes' do
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
      @biker.learn_terrain(:gravel)
      @biker.learn_terrain(:hills)

      @biker.log_ride(@ride1, 92.5)
      @biker.log_ride(@ride1, 91.1)
      @biker.log_ride(@ride2, 60.9)
      @biker.log_ride(@ride2, 61.6)

      expected = {
        @ride1 => [92.5, 91.1],
        @ride2 => [60.9, 61.6]
      }

      expect(@biker.rides).to eq(expected)
    end

    it 'does not log rides if terrain is not known' do
      @biker2.log_ride(@ride1, 97.0)
      @biker2.log_ride(@ride2, 67.0)

      expect(@biker2.rides).to eq({})
    end

    it 'does not log rides if distance is too long' do
      @biker2.learn_terrain(:gravel)
      @biker2.learn_terrain(:hills)

      @biker2.log_ride(@ride1, 95.0) #too long
      @biker2.log_ride(@ride2, 65.0) #Should work

      expect(@biker2.rides).to eq({@ride2 => [65.0]})
    end
  end

  describe '#personal_record' do
    it 'returns personal record for a ride' do
      @biker.learn_terrain(:gravel)
      @biker.learn_terrain(:hills)

      @biker.log_ride(@ride1, 92.5)
      @biker.log_ride(@ride1, 91.1)
      @biker.log_ride(@ride2, 60.9)
      @biker.log_ride(@ride2, 61.6)

      expect(@biker.personal_record(@ride1)).to eq(91.1)
      expect(@biker.personal_record(@ride2)).to eq(60.9)
    end

    it 'returns false if the biker has not completed a ride' do
      expect(@biker2.personal_record(@ride1)).to eq(false)
    end
  end

  describe '#can_complete_ride?' do
    it 'can determine if a biker can complete a ride' do
      @biker.learn_terrain(:hills)
      @biker.learn_terrain(:gravel)
      @biker2.learn_terrain(:gravel)

      expect(@biker.can_complete_ride?(@ride1)).to be true
      expect(@biker.can_complete_ride?(@ride2)).to be true
      expect(@biker2.can_complete_ride?(@ride1)).to be false #does not know terrain
      expect(@biker2.can_complete_ride?(@ride2)).to be true
    end
  end
end