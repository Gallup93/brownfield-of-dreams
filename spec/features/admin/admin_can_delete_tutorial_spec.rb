require 'rails_helper'

feature "An admin can delete a tutorial" do
  scenario "and it should no longer exist" do
    admin = create(:admin)
    
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial)
    
    video1 = Video.create!({
      "title"=>"Prework - Environment Setup",
      "description"=> Faker::Hipster.paragraph(2, true),
      "video_id"=>"qMkRHW9zE1c",
      "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
      "position"=>1,
      "tutorial_id"=> tutorial1.id
    })

    video2 = Video.create!({
      "title"=>"Prework - SSH Key Setup",
      "description"=> Faker::Hipster.paragraph(2, true),
      "video_id"=>"XsPVWGKK0qI",
      "thumbnail"=>"https://i.ytimg.com/vi/XsPVWGKK0qI/hqdefault.jpg",
      "position"=>2,
      "tutorial_id"=> tutorial1.id
    })

    video3 = Video.create!({
      "title"=>"Prework - Strings",
      "description"=> Faker::Hipster.paragraph(2, true),
      "video_id"=>"iXLwXvev4X8",
      "thumbnail"=>"https://i.ytimg.com/vi/iXLwXvev4X8/hqdefault.jpg",
      "position"=>3,
      "tutorial_id"=> tutorial2.id
    })

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(page).to have_css('.admin-tutorial-card', count: 2)

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end
    expect(page).to have_css('.admin-tutorial-card', count: 1)
    expect(Tutorial.all).to_not include(tutorial1)
    expect(Video.all).to_not include(video1, video2)
    expect(Video.all).to include(video3)
  end
end


# Background: Currently deleting a
# Tutorial will leave all of the videos in the database,
# meaning they will be referencing a tutorial that doesn't exist.

# Use ActiveRecords dependent destroy
# functionality to fix this.