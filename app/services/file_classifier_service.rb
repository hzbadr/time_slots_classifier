require 'json'

class FileClassifierError < StandardError; end

class FileClassifierService < BaseService
  def initialize(time_slots_file, fields_file)
    @time_slots = JSON.parse(time_slots_file)
    @fields = JSON.parse(fields_file)
  end

  def call
    create_activities
  end

  private
    def create_activities
      group_time_slots_by_driver.each do |driver_id, slots|
        CreateDriverActivitiesService.call(driver_id, slots, @fields)
      end
    end

    def group_time_slots_by_driver
      @time_slots.group_by { |slot| slot[:driver_id] }
    end
end