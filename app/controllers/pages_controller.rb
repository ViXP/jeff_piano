class PagesController < ApplicationController
  def play
    render :play, status: :ok
  end

  def statistics
    render :statistics, locals: {
      recordings_stats: Statistic.recordings_stats,
      distribution_stats: Statistic.distribution_stats,
      average_rate: Statistic.average_rate_stats,
      recordings: Recording.with_duration.all,
      clips: Clip.all
    }
  end
end
