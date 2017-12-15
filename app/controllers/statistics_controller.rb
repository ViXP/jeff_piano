class StatisticsController < ApplicationController
  def show
    render :show, locals: {
      recordings_stats: Statistic.recordings_stats,
      distribution_stats: Statistic.distribution_stats,
      average_rate: Statistic.average_rate_stats,
      recordings: Recording.all,
      clips: Clip.all
    }
  end
end
