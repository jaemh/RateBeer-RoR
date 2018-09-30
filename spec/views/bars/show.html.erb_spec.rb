require 'rails_helper'

RSpec.describe "bars/show", type: :view do
  before(:each) do
    @bar = assign(:bar, Bar.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
