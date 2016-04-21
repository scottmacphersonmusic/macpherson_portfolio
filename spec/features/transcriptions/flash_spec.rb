require 'rails_helper'

describe 'flash messages', js: true do
  it 'should be removable by click' do
    User.create!(
      email: 'scomo@example.com',
      password: 'supersecret',
      password_confirmation: 'supersecret'
    )

    # sign in
    visit root_path
    click_on 'Sign In'
    fill_in 'Email', with: 'scomo@example.com'
    fill_in 'Password', with: 'supersecret'
    click_on 'Log in'

    save_and_open_page

    visit new_transcription_path
    # fill nothing out
    click_on 'Create Transcription'
    click_on 'close'

    expect(page).to_not have_content('There was a problem creating your transcription')
  end
end
