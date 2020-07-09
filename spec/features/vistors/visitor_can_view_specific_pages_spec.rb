require 'rails_helper'

describe "visitor" do
  it "can view 'about' page" do
    visit "/about"
    expect(page).to have_css(".about-main")
  end

  it "can view 'about' page" do
    visit "/get_started"
    expect(page).to have_css(".started-main")
  end
end
