require 'rails_helper'

describe 'flash messages', js: true do
  it 'should be removable by click' do
    visit new_transcription_path
    # fill nothing out
    click_on 'Create Transcription'
    click_on 'close'

    expect(page).to_not have_content('There was a problem creating your transcription')
  end
end
