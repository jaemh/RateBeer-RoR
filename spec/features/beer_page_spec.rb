require 'rails_helper'

include Helpers

describe "Beer" do
    before :each do
      FactoryBot.create :brewery
    end

    describe ", when logged in" do
      before :each do
        FactoryBot.create :user
        sign_in(username:"Pekka", password:"Foobar1")
        visit new_beer_path
      end

      it "create if valid name" do
        fill_in('beer_name', with:'Karhu')
    
        expect{
          click_button "Create Beer"
        }.to change{Beer.count}.from(0).to(1)

        expect(current_path).to eq(beers_path)
        expect(page).to have_content "Beer was successfully created."
      end

      it "can't create if invalid name" do
        click_button('Create Beer')
        expect(page).to have_content "Name can't be blank"
      end
	end
end