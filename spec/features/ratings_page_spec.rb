require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryBot.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  describe "ratings" do
    before :each do
      @ratings = [7, 5, 6, 4]
      @ratings.each do |score|
        FactoryBot.create(:rating, beer: beer1, score: score, user: user)
      end
    end

    it "has amount of ratings" do
      visit ratings_path
      expect(page).to have_content "Amount of ratings: 4"
    end

    it "has list of all ratings" do
      visit ratings_path
      @ratings.each do |rating|
        expect(page).to have_content "iso 3"
        expect(page).to have_content rating
      end
    end
  end
end