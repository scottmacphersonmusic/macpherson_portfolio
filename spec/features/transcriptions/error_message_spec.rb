require 'rails_helper'

describe 'error messages' do
  it 'should highlight form fields that have errors' do
    visit new_transcription_path
    # fill nothing out
    click_on 'Create Transcription'

    expect(page.find_all('div.field_with_errors').count).to equal(10)
  end
end
