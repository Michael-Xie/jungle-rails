require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    @user = User.create! first_name:"tester", last_name: "testing", email: 'test@test.com', password: 'hellotest', password_confirmation: 'hellotest'
  end

  scenario "They see home page when logged in" do
    visit root_path

    click_link "Login"
    expect(page).to have_content "Email"

    fill_in 'email', with:'test@test.com'
    fill_in 'password', with: 'hellotest'
    click_button "Submit"
    puts page.html
    # commented out b/c it's for debugging only
    # save_and_open_screenshot
    expect(page).to have_content "Logout"

  end
end
