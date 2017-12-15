class RecordingsController < ApplicationController
  before_action :set_recording, only: [:show, :destroy]

  def index
    render json: Recording.all
  end

  def show
    if @recording
      render json: @recording
    else

    end
  end

  def create
    recording = Recording.new(recording_params)

    if recording.save
      render json: recording, status: :created
    else
      render json: recording.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @recording.destroy
      flash[:notice] = 'Recording was successfully destroyed.'
    else
      flash[:alert] = 'Error occured'
    end
    redirect_to :statistics, notice: notice || nil
  end

  private

  def set_recording
    @recording = Recording.find(params[:id])
  end

  def recording_params
    params.require(:recording).permit(:title)
  end
end
