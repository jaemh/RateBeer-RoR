require 'rails_helper'

RSpec.describe "bars/index", type: :view do
  before(:each) do
    assign(:bars, [
      Bar.create!(
        :name => "Name"
      ),
      Bar.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of bars" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
