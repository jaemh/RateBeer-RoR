require 'rails_helper'

RSpec.describe "styles/index", type: :view do
  before(:each) do
    assign(:styles, [
      Style.create!(
        :name => "Name",
        :style_id => 2,
        :beer_id => 3
      ),
      Style.create!(
        :name => "Name",
        :style_id => 2,
        :beer_id => 3
      )
    ])
  end

  it "renders a list of styles" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
