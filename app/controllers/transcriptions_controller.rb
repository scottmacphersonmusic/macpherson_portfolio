class TranscriptionsController < ApplicationController
  def index
    @transcriptions = Transcription.order(:soloist_last_name)
  end

  def show
    @transcription = Transcription.find(params[:id])
  end

  def new
    @transcription = Transcription.new
  end

  def create
    @transcription = Transcription.new(transcription_params)

    if @transcription.save
      flash[:success] = 'Transcription Succesfully Created'
      redirect_to transcriptions_path
    else
      flash.now[:error] = 'There was a problem creating your transcription'
      render :new
    end
  end

  private

  def transcription_params
    params.require(:transcription)
          .permit(
            :song_title,
            :soloist_first_name,
            :soloist_last_name,
            :pdf,
            :mp3
          )
  end
end
