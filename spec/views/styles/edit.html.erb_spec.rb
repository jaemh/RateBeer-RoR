require 'rails_helper'

RSpec.describe "styles/edit", type: :view do
  before(:each) do
    @style = assign(:style, Style.create!(
      :name => "MyString",
      :style_id => 1,
      :beer_id => 1
    ))
  end

  it "renders the edit style form" do
    render

    assert_select "form[action=?][method=?]", style_path(@style), "post" do

      assert_select "input[name=?]", "style[name]"

      assert_select "input[name=?]", "style[style_id]"

      assert_select "input[name=?]", "style[beer_id]"
    end
  end
end
