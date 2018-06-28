require 'ostruct'

module Driver
  class ActivityFactory
    def self.create(slots, fields)
      slots.inject([]) do |activities, slot|
        slot  = OpenStruct.new(slot)
        activity = Driver::ActivityFactory.new(slot, fields).create
        prev_activity = activities.last

        if prev_activity && prev_activity.same_as?(activity)
          prev_activity.merge(activity)
        else
          activities << activity
        end

        activities
      end
    end

    attr_reader :slot, :fields

    def initialize(slot, fields)
      @slot = slot
      @fields = fields
    end

    def create
      activity_class.new(slot)
    end

    def in_field?
      fields.any? { |field| field.surrounding?(slot.latitude, slot.longitude) }
    end

    def activity_class
      if in_field?
        if slot.speed > 1
          Cultivating
        else
          Repairing
        end
      elsif slot.speed > 5
        Driving
      else
        Driving # I should not handle this case!
      end
    end
  end

end