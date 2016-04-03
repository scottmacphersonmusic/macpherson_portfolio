class Transcription < ActiveRecord::Base
  mount_uploader :pdf, PdfUploader
  mount_uploader :mp3, Mp3Uploader

  validates :song_title,
            :soloist_first_name,
            :soloist_last_name,
            :pdf,
            :mp3,
            presence: true
end
