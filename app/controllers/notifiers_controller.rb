class NotifiersController < ApplicationController

  def create
    FileReceivedJob.perform_later(params[:time_slots_url], params[:fields_url])
  end
end
