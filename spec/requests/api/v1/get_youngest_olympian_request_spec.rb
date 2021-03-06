require 'rails_helper'

RSpec.describe 'Olympians API' do
  describe 'GET youngest olympian request' do
    before(:each) do
      @korea = Team.create!(name: "South Korea")
      @usa = Team.create!(name: "United States")
      @taekwondo = Sport.create!(name: "Tae Kwon Do")
      @boxing = Sport.create!(name: "Boxing")
      @mens_tkd = Event.create!(name: "Men's Tae Kwon Do", sport: @taekwondo)
      @mens_boxing = Event.create!(name: "Men's Boxing", sport: @boxing)
      @sejin = Olympian.create!(
        name: "Sejin Kim",
        age: 31,
        sex: "M",
        weight: 185,
        height: 60,
        team: @korea,
        sport: @taekwondo
      )
      @jaren = Olympian.create!(
        name: "Jaren Kim",
        age: 36,
        sex: "M",
        weight: 185,
        height: 60,
        team: @usa,
        sport: @boxing
      )
      OlympianEvent.create!(
        olympian: @sejin,
        event: @mens_tkd,
        medal: "Gold"
      )
      OlympianEvent.create!(
        olympian: @jaren,
        event: @mens_boxing,
        medal: nil
      )
    end

    it "returns the youngest olympian" do
      get '/api/v1/olympians?age=youngest'

      expect(response).to be_successful

      olympian = JSON.parse(response.body)

      expect(olympian["data"]).to have_key("id")
      expect(olympian["data"]).to have_key("type")
      expect(olympian["data"]["attributes"]["name"]).to eq(@sejin.name)
      expect(olympian["data"]["attributes"]["age"]).to eq(@sejin.age)
      expect(olympian["data"]["attributes"]["sport"]).to eq(@sejin.sport.name)
      expect(olympian["data"]["attributes"]["team"]).to eq(@sejin.team.name)
      expect(olympian["data"]["attributes"]["total_medals_won"]).to eq(@sejin.total_medals_won.size)
    end
  end
end
