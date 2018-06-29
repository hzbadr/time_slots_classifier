class CreateDriverActivitiesJob < ApplicationJob
  queue_as :default

  def perform(driver_id, slots, fields)
    CreateDriverActivitiesService.new(driver_id, slots, fields).call
  end
end
