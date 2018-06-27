require 'json'

class FileClassifierError < StandardError; end

class FileClassifierService < BaseService
  def initialize(time_slots_file, fields_file)
    @time_slots = JSON.parse(time_slots_file)
    @fields = JSON.parse(fields_file)
  end
  
  def call
    sort_time_slots
    group_time_slots_by_driver
    build_activities
  end

  private

    def build_activities
      @time_slots.map do |driver_id, slots|
        time_slots_splited_by_date(slots).map do |daily_slots|
          Driver::ActivityBuilder.build(daily_slots, fields)
        end
      end
    end

    def time_slots_splited_by_date(slots)
      slots.split{|slot| Date.strptime(slot[:timestamp].to_s,'%s')}
    end

    def sort_time_slots
      @time_slots = @time_slots.sort_by { |slot| slot[:timestamp] }
    end

    def group_time_slots_by_driver
      @time_slots.group_by(:driver_id)
    end

    def fields
      @fields.map do |field|
        Driver::Field.new(field[0], field[1])
      end
    end
end