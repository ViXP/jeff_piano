class ClipsController < ApplicationController
  def index
    render :index, locals: { clips: Clip.all },
      status: :ok
  end

  def new
    render :new, locals: { clip: Clip.new }
  end

  def create
    clip = Clip.new(recording_params)
    if clip.save
      redirect_to :root, notice: 'New clip created successfully'
    else
      flash[:alert] = 'Errors occured!'
      render :new, locals: { clip: clip }
    end
  end

  def destroy
    if Clip.destroy(params[:id])
      redirect_to :statistics, notice: 'Clip is successfully destroyed!'
    else
      flash[:alert] = 'This clip can not be destroyed!'
      render :statistics
    end
  end

  private

  def recording_params
    params.require(:clip).permit(:number, :url)
  end
end
