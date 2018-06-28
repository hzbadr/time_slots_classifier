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
    sort_time_slots
    group_time_slots_by_driver
    # build_activities
  end

  private

    def build_activities
      @grouped_time_slots.inject({}) do |accumlator, slots|
        accumlator.merge({ slots[0] => build_daily_activities_for_driver(slots[1]) })
      end
    end

    def build_daily_activities_for_driver(slots)
      time_slots_grouped_by_date(slots).inject({}) do |accumlator, daily_slots|
        accumlator.merge({ daily_slots[0] => Driver::ActivityBuilder.build(daily_slots[1], fields) })
      end
    end

    def time_slots_grouped_by_date(slots)
      slots.group_by { |slot| Date.strptime(slot[:timestamp].to_s,'%s') }
    end

    def sort_time_slots
      @time_slots = @time_slots.sort_by { |slot| slot[:timestamp] }
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