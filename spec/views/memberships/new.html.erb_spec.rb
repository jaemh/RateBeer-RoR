require 'rails_helper'

RSpec.describe "memberships/new", type: :view do
  before(:each) do
    assign(:membership, Membership.new(
      :beer_club_id => 1,
      :user_id => 1
    ))
  end

  it "renders new membership form" do
    render

    assert_select "form[action=?][method=?]", memberships_path, "post" do

      assert_select "input[name=?]", "membership[beer_club_id]"

      assert_select "input[name=?]", "membership[user_id]"
    end
  end
end
