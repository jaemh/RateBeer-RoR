require 'rails_helper'

RSpec.describe "styles/new", type: :view do
  before(:each) do
    assign(:style, Style.new(
      :name => "MyString",
      :text => "MyString"
    ))
  end

  it "renders new style form" do
    render

    assert_select "form[action=?][method=?]", styles_path, "post" do

      assert_select "input[name=?]", "style[name]"

      assert_select "input[name=?]", "style[text]"
    end
  end
end
