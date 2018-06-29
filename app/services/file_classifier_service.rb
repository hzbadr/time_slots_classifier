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
    group_time_slots_by_driver
    build_activities
  end

  private
    def group_time_slots_by_driver
      @grouped_time_slots = @time_slots.group_by { |slot| slot[:driver_id] }
    end

    def build_activities
      @grouped_time_slots.each do |driver_id, slots|
        build_daily_activities_for_driver(driver_id, slots)
      end
    end

    def build_daily_activities_for_driver(driver_id, slots)
      time_slots_grouped_by_date(slots).each do |date, daily_slots|
        daily_activities = Driver::ActivityFactory.create(daily_slots, fields)
        daily_activities.each do |activity|
          DailyActivity.create(driver_id: driver_id, day: date,
                               start_at: activity.start_at,
                               end_at: activity.end_at,
                               activity_type: activity.type
                              )
        end
      end
    end

    def time_slots_grouped_by_date(slots)
      slots.group_by { |slot| Date.strptime(slot[:timestamp].to_s,'%s') }
    end

    def fields
      return @fields
      @fields.map do |field|
        Driver::Field.new(field[0], field[1])
      end
    end
end