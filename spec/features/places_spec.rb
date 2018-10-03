require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "show plural places" do
    allow(BeermappingApi).to receive(:places_in).with("helsinki").and_return(
      [ Place.new( name:[:name]) ]
    )

    visit places_path
    fill_in('city', with: 'helsinki')
    click_button "Search"

    expect(page).to have_content "#{[:name]}"
  end

  it "if no bars in the city" do
    allow(BeermappingApi).to receive(:places_in).with("kuusamo").and_return(
      [ Place.new(name:"") ]
    )

    visit places_path
    fill_in('city', with: 'kuusamo')
    click_button "Search"

    expect(page).to have_content "No places in kuusamo"
  end
end