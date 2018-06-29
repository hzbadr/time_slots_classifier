module Driver
  class Activity

    attr_reader :start_time, :end_time

    def initialize(slot)
      @slot = slot
      @start_time = @slot.timestamp
      @end_time = @slot.timestamp
    end

    def duration
      end_time - start_time
    end

    def timestamp
      @slot.timestamp
    end

    def start_at
      Time.strptime(start_time.to_s,'%s')
    end

    def end_at
      Time.strptime(end_time.to_s,'%s')
    end

    def driver_id
      @slot.driver_id
    end

    def merge(activity)
      @end_time = activity.timestamp
    end

    def same_as?(activity)
      activity.class == self.class
    end

    def type
      self.class.name.split("::").last
    end

  end
end
