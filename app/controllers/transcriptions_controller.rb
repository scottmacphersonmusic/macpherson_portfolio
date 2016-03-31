class TranscriptionsController < ApplicationController
  def index
    @transcriptions = Transcription.all
  end

  def show
    @transcription = Transcription.find(params[:id])
  end
end
