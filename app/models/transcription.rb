class Transcription < ActiveRecord::Base
  mount_uploader :pdf, PdfUploader
end
