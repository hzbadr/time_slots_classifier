require 'ostruct'

module Driver
  class ActivityFactory
    #TODO HZ: need a refactor here.
    def self.build(slots, fields, action_class=Driver::ActionClass)
      slots.inject([]) do |activities, slot|
        activity = Driver::ActivityFactory.new(slot, fields, action_class).build
        prev_activity = activities.last

        if activity.same_as?(prev_activity)
          prev_activity.merge(activity)
        else
          activities << activity
        end

        activities
      end
    end

    attr_reader :slot, :fields

    def initialize(slot, fields, action_class)
      @slot = OpenStruct.new(slot)
      @fields = fields
      @action_class = action_class
    end

    def build
      activity_class.new(slot)
    end

    def activity_class
      @action_class.new(slot, fields).activity_class
    end
  end
end
