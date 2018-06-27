class FileReceivedJob < ApplicationJob
  queue_as :default

  def perform(time_slots_path, fields_path)
    FileReceivedService.call(time_slots_path, fields_path)
  end
end
