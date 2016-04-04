class TranscriptionsController < ApplicationController
  before_action :transcription, only: [:new, :show, :edit]

  def index
    @transcriptions = Transcription.order(:soloist_last_name)
  end

  def new
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

  def show
  end

  def edit
  end

  def update
    if transcription.update_attributes(transcription_params)
      flash[:success] = 'Transcription Successfully Updated'
      redirect_to transcriptions_path
    else
      flash.now[:error] = 'There was a problem updating your transcription'
      render :edit
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

  def transcription
    @transcription ||=
      params[:id] ? Transcription.find(params[:id]) : Transcription.new
  end
end
