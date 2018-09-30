require 'rails_helper'

RSpec.describe "bars/edit", type: :view do
  before(:each) do
    @bar = assign(:bar, Bar.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit bar form" do
    render

    assert_select "form[action=?][method=?]", bar_path(@bar), "post" do

      assert_select "input[name=?]", "bar[name]"
    end
  end
end
