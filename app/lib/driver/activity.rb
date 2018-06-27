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

    def merge(activity)
      @end_time = activity.timestamp
    end

    def same_as?(activity)
      activity.is_a? self.class 
    end
  end
end