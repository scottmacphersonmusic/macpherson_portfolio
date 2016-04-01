class TranscriptionsController < ApplicationController
  def index
    @transcriptions = Transcription.order(:soloist_last_name)
  end

  def show
    @transcription = Transcription.find(params[:id])
  end
end
