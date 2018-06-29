class CreateDriverActivitiesService < BaseService

  attr_reader :driver_id, :slots, :fields
  def initialize(driver_id, slots, fields)
    @driver_id = driver_id
    @slots = slots
    @fields = fields.map{ |field| Driver::Field.new(field) }
  end

  def call
    DailyActivity.import!(daily_activities_for_driver)
  end

  private
    def daily_activities_for_driver
      time_slots_grouped_by_date.map do |day, daily_slots|
        daily_activities = Driver::ActivityFactory.build(daily_slots, fields)
        daily_activities.map do |activity|
          { driver_id: driver_id, day: day,
            start_at: activity.start_at,
            end_at: activity.end_at,
            activity_type: activity.type
          }
        end.flatten
      end.flatten
    end

    def time_slots_grouped_by_date
      slots.group_by { |slot| Date.strptime( slot["timestamp"].to_s,'%s') }
    end
end