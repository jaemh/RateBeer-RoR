require 'rails_helper'

RSpec.describe "styles/new", type: :view do
  before(:each) do
    assign(:style, Style.new(
      :name => "MyString",
      :style_id => 1,
      :beer_id => 1
    ))
  end

  it "renders new style form" do
    render

    assert_select "form[action=?][method=?]", styles_path, "post" do

      assert_select "input[name=?]", "style[name]"

      assert_select "input[name=?]", "style[style_id]"

      assert_select "input[name=?]", "style[beer_id]"
    end
  end
end
