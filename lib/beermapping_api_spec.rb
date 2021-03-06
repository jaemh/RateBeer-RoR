require 'rails_helper'

describe "BeermappingApi" do
    
    it "When HTTP GET returns one entry, it is parsed and returned" do

        canned_answer = <<-END_OF_STRING
        <?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>12411</id><name>Gallows Bird</name><status>Brewery</status><reviewlink>https://beermapping.com/location/12411</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=12411&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=12411&amp;d=1&amp;type=norm</blogmap><street>Merituulentie 30</street><city>Espoo</city><state></state><zip>02200</zip><country>Finland</country><phone>+358 9 412 3253</phone><overall>91.66665</overall><imagecount>0</imagecount></location><location><id>21108</id><name>Captain Corvus</name><status>Beer Bar</status><reviewlink>https://beermapping.com/location/21108</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=21108&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=21108&amp;d=1&amp;type=norm</blogmap><street>Suomenlahdentie 1</street><city>Espoo</city><state>Etela-Suomen Laani</state><zip>02230</zip><country>Finland</country><phone>+358 50 4441272</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>21496</id><name>Olarin panimo</name><status>Brewery</status><reviewlink>https://beermapping.com/location/21496</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=21496&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=21496&amp;d=1&amp;type=norm</blogmap><street>Pitkäniityntie 1</street><city>Espoo</city><state>Etela-Suomen Laani</state><zip>02810</zip><country>Finland</country><phone>045 6407920</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>21516</id><name>Fat Lizard Brewing</name><status>Brewery</status><reviewlink>https://beermapping.com/location/21516</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=21516&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=21516&amp;d=1&amp;type=norm</blogmap><street>Lämpömiehenkuja 3</street><city>Espoo</city><state>Etela-Suomen Laani</state><zip>02150</zip><country>Finland</country><phone>09 23165432</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>21545</id><name>Simapaja</name><status>Brewery</status><reviewlink>https://beermapping.com/location/21545</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=21545&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=21545&amp;d=1&amp;type=norm</blogmap><street>Kipparinkuja 2</street><city>Espoo</city><state>Etela-Suomen Laani</state><zip>02320</zip><country>Finland</country><phone></phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
        END_OF_STRING
    
        stub_request(:get, /.*espoo/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })
    
        places = BeermappingApi.places_in("espoo")
    
        expect(places.size).to eq(5)
        place = places.first
        expect(place.name).to eq("Gallows Bird")
        expect(place.street).to eq("Merituulentie 30")
      end

  it "When HTTP GET returns an empty page" do
    canned_answer = <<-END_OF_STRING
    <?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id></id><name></name><status></status><reviewlink></reviewlink><proxylink></proxylink><blogmap></blogmap><street></street><city></city><state></state><zip></zip><country></country><phone></phone><overall></overall><imagecount></imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*kuusamo/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("kuusamo")

    expect(places.size).to eq(0)
  end

  it "When HTTP GET returns several places" do
    canned_answer = <<-END_OF_STRING
    <?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>21528</id><name>Maistila</name><status>Brewery</status><reviewlink>https://beermapping.com/location/21528</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=21528&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=21528&amp;d=1&amp;type=norm</blogmap><street>Kaarnatie 20</street><city>Oulu</city><state>Oulun Laani</state><zip>90530</zip><country>Finland</country><phone>044 291 9589</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>21547</id><name>Sonnisaari</name><status>Brewery</status><reviewlink>https://beermapping.com/location/21547</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=21547&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=21547&amp;d=1&amp;type=norm</blogmap><street>Tuotekuja 1</street><city>Oulu</city><state>Oulun Laani</state><zip>90410</zip><country>Finland</country><phone></phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*oulu/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("oulu")

    expect(places.name).to eq("Maistila")
    expect(places.name).to eq("Oulu")
  end 

  describe "BeermappingApi" do
    describe "in case of cache miss" do
  
      before :each do
        Rails.cache.clear
      end
  
      it "When HTTP GET returns one entry, it is parsed and returned" do
        canned_answer = <<-END_OF_STRING
        <?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>12411</id><name>Gallows Bird</name><status>Brewery</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=12411</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=12411&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=12411&amp;d=1&amp;type=norm</blogmap><street>Merituulentie 30</street><city>Espoo</city><state></state><zip>02200</zip><country>Finland</country><phone>+358 9 412 3253</phone><overall>91.66665</overall><imagecount>0</imagecount></location></bmp_locations>
        END_OF_STRING
  
        stub_request(:get, /.*espoo/).to_return(body: canned_answer, headers: {'Content-Type' => "text/xml"})
  
        places = BeermappingApi.places_in("espoo")
  
        expect(places.size).to eq(1)
        place = places.first
        expect(place.name).to eq("Gallows Bird")
        expect(place.street).to eq("Merituulentie 30")
      end
  
    end
  
    describe "in case of cache hit" do
      before :each do
        Rails.cache.clear
      end
  
      it "When one entry in cache, it is returned" do
        canned_answer = <<-END_OF_STRING
        <?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>13307</id><name>O'Connell's Irish Bar</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=13307</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=13307&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=13307&amp;d=1&amp;type=norm</blogmap><street>Rautatienkatu 24</street><city>Tampere</city><state></state><zip>33100</zip><country>Finland</country><phone>35832227032</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
        END_OF_STRING
  
        stub_request(:get, /.*espoo/).to_return(body: canned_answer, headers: {'Content-Type' => "text/xml"})
  
        places = BeermappingApi.places_in("espoo")
  
        expect(places.size).to eq(1)
        place = places.first
        expect(place.name).to eq("O'Connell's Irish Bar")
        expect(place.street).to eq("Rautatienkatu 24")
      end
    end
  end
end