require 'rails_helper'

describe 'transcriptions' do
  context 'index' do
    before do
      Transcription.create!(
        song_title: 'Oleo',
        soloist_first_name: 'John',
        soloist_last_name: 'Coltrane'
      )
      Transcription.create!(
        song_title: 'Daahoud',
        soloist_first_name: 'Clifford',
        soloist_last_name: 'Brown'
      )

      visit transcriptions_path
    end

    it 'should list all available transcriptions' do
      expect(page).to have_content 'Oleo'
      expect(page).to have_content 'Daahoud'
    end

    it 'should be organized by soloist last name' do
      solos = page.all('li a').map { |solo| solo.text }

      expect(solos.first).to match(/Daahoud/)  # Brown
      expect(solos.second).to match(/Oleo/)    # Coltrane
    end
  end

  context 'show' do
    include ActionDispatch::TestProcess

    before do
      Transcription.create!(
        song_title: 'Oleo',
        soloist_first_name: 'John',
        soloist_last_name: 'Coltrane',
        pdf: Rails.root.join(
          'spec/fixtures/files/oleo_coltrane.pdf').open,
        mp3: Rails.root.join(
          'spec/fixtures/files/oleo_coltrane.mp3').open
      )

      visit root_path
      click_on 'Oleo'
    end

    it 'should provide a link to view pdf full-screen in a new tab' do
      full_screen_link = page.find(:xpath, '//a', text: 'View Full Screen')

      expect(full_screen_link[:href]).to match(/pdfjs\/full\?file=.*oleo_coltrane/)
      expect(full_screen_link[:target]).to match(/_blank/)

      full_screen_link.click

      expect(page).to have_xpath('//body[@id = "pdfjs_viewer-full"]')
    end

    it 'should display a pdf of the transcription' do
      pdf_viewer = page.find(:xpath, '//iframe')
      expect(pdf_viewer[:src]).to match(/pdfjs\/minimal\?file=.*oleo_coltrane/)
    end

    it 'should have a basic audio player' do
      expect(page).to have_xpath('//audio[@src = "/audios/oleo_coltrane.mp3"]')
    end
  end

  context 'new/create' do
    include ActionDispatch::TestProcess

    it 'should allow me to create a new transcription' do
      visit transcriptions_path
      click_on 'New Transcription'
      fill_in 'Song title', with: 'Oleo'
      fill_in 'Soloist first name', with: 'John'
      fill_in 'Soloist last name', with: 'Coltrane'
      attach_file 'Pdf',
                  Rails.root.join(
                    'spec/fixtures/files/oleo_coltrane.pdf')
      attach_file 'mp3',
                  Rails.root.join(
                    'spec/fixtures/files/oleo_coltrane.mp3')
      click_on 'Create Transcription'

      expect(page)
        .to have_content('Transcription Succesfully Created')
      expect(page)
        .to have_xpath('//audio[@src = "/audios/oleo_coltrane.mp3"]')
      expect(page.find(:xpath, '//iframe')[:src])
        .to match(/pdfjs\/minimal\?file=.*oleo_coltrane/)
    end
  end
end
