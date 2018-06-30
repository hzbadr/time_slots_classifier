module Driver
  class ActionClass
    def initialize(slot, fields)
      @slot = slot
      @fields = fields
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

    private
      def in_field?
        @fields.any? { |field| field.surrounding?(@slot.latitude, @slot.longitude) }
      end
  end
end
