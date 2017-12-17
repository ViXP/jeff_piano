class RecordingsController < ApplicationController
  def index
    render :index, locals: { recordings: Recording.all },
      status: :ok
  end

  def show
    recording = Recording.find_by_id(params[:id])
    unless recording.nil?
      render :show, locals: { recording: recording }, status: :ok
    else
      head :not_found
    end
  end

  def create
    recording = Recording.new(recording_params)
    if recording.save
      render :show, locals: { recording: recording }, status: :created
    else
      render json: recording.errors, status: :unprocessable_entity
    end
  end

  def destroy
    recording = Recording.find(params[:id])
    if recording && recording.destroy
      flash[:notice] = 'Recording was successfully destroyed.'
    else
      flash[:alert] = 'Error occured'
    end
    redirect_to :statistics, notice: notice || nil
  end

  private

  def recording_params
    params.require(:recording).permit(:title, :clips)
  end
end
