class PagesController < ApplicationController
  def entry_point
    render :entry_point, status: :ok
  end
end
