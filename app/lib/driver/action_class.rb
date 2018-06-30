module Driver
  class ActionClass
    def initialize(slot)
      @slot = slot
    end

    def activity_class
      if in_field?
        if @slot.speed > 1
          Cultivating
        else
          Repairing
        end
      elsif @slot.speed > 5
        Driving
      end
    end
  end
end
