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
      solos = page.all('a').map { |solo| solo.text }

      expect(solos.first).to match(/Daahoud/)  # Brown
      expect(solos.second).to match(/Oleo/)    # Coltrane
    end
  end

  context 'show' do
    before do
      Transcription.create!(
        song_title: 'Oleo',
        pdf: 'oleo_coltrane.pdf',
        mp3: 'oleo_coltrane.mp3'
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
end
