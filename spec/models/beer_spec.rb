require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "beer name has set correctly" do
    beer = Beer.new name:"JustBeer"

    expect(beer.name).to eq("JustBeer")
  end

  it "beer style has set correctly" do
    beer = Beer.new style:"Lager"

    expect(beer.style).to eq("Lager")
  end

  it "brewery and beer has set correctly" do
    brewery = Brewery.new name: "Holland", year:Time.now.year
    beer = Beer.new name:"Amsterdam", brewery: brewery

    expect(beer.brewery).to eq(brewery)
  end

  describe "is saved" do

    it "when brewery, beers name and style has set correctly" do
      brewery = Brewery.create name: "Holland", year:Time.now.year
      beer = Beer.create name:"Amsterdam", style:"Lager", brewery: brewery

      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end

  describe "is not saved" do

    it "when beer name is nil" do
      brewery = Brewery.create name: "Holland", year:Time.now.year
      beer = Beer.create style:"Lager", brewery: brewery

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
  end
end