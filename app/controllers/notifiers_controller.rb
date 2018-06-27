class NotifiersController < ApplicationController

  def create
    FileReceivedJob.perform_later(params[:time_slots_path], params[:fields_path])
  end
end
