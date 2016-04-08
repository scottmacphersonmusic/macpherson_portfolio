require 'rails_helper'

describe 'error messages' do
  it 'should require javascript testing to work', js: true do
    visit transcriptions_path
    click_on 'javascript'

    expect(page).to have_content('JavaScript is getting tested!!!')
  end
end
