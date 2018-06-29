require 'json'

class FileClassifierError < StandardError; end

class FileClassifierService < BaseService
  def initialize(time_slots_file, fields_file)
    # @time_slots = JSON.parse(time_slots_file)
    @time_slots = time_slots_file
    # @fields = JSON.parse(fields_file)
    @fields = fields_file
    @grouped_time_slots = []
  end

  def call
    create_activities
    true
  end

  private
    def create_activities
      group_time_slots_by_driver.each do |driver_id, slots|
        CreateDriverActivitiesService.call(driver_id, slots, fields)
      end
    end

    def group_time_slots_by_driver
      @grouped_time_slots = @time_slots.group_by { |slot| slot[:driver_id] }
    end

    def fields
      return @fields
      @fields.map do |field|
        Driver::Field.new(field[0], field[1])
      end
    end
end