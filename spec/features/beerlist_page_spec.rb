require 'rails_helper'

describe "Beerlist page" do
  before :all do
    Capybara.register_driver :selenium do |app|
        capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
            chromeOptions: { args: ['headless', 'disable-gpu']  }
          )
      
          Capybara::Selenium::Driver.new app,
            browser: :chrome,
            desired_capabilities: capabilities      
        end
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name:"Koff")
    @brewery2 = FactoryBot.create(:brewery, name:"Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name:"Ayinger")
    @style1 = Style.create name:"Lager"
    @style2 = Style.create name:"Rauchbier"
    @style3 = Style.create name:"Weizen"
    @beer1 = FactoryBot.create(:beer, name:"Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name:"Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name:"Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  it "shows one known beer", js:true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    save_and_open_page
    expect(page).to have_content "Nikolai"
  end

  it "beers are in alphabetical order ", js:true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    save_and_open_page
    Beer.order('name').all.should == [@beer2, @beer3, @beer1]
  end

  it "on click style beers are arranged by style", js:true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    save_and_open_page
    Style.order('name').all.should == [@style1, @style2, @style3]
  end

  it "on click brewery beers are arranged by brewery", js:true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    save_and_open_page
    Brewery.order('name').all.should == [@brewery3, @brewery1, @brewery2]
  end
end