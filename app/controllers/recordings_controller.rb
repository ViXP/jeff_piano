class RecordingsController < ApplicationController
  def index
    render :index, locals: { recordings: Recording.all },
      status: :ok
  end

  def show
    recording = Recording.find_by_id(params[:id])
    if recording.nil?
      head :not_found
    else
      render :show, locals: { recording: recording }, status: :ok
    end
  end

  def create
    recording = Recording.new(recording_params)
    if recording.save
      head :created
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
    params.require(:recording).permit(
      :title,
      recording_clips_attributes: [:number, :start_time]
    )
  end
end
