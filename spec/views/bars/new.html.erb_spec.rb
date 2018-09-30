require 'rails_helper'

RSpec.describe "bars/new", type: :view do
  before(:each) do
    assign(:bar, Bar.new(
      :name => "MyString"
    ))
  end

  it "renders new bar form" do
    render

    assert_select "form[action=?][method=?]", bars_path, "post" do

      assert_select "input[name=?]", "bar[name]"
    end
  end
end
