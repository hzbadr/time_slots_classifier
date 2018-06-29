module Driver
  class Field

    include Geometry
    # For more details check this link.
    # https://github.com/DanielVartanov/ruby-geometry/blob/5ee2eb0639589f7bcbd2356819ede2fd2708bae5/test/polygon/contains_point_test.rb

    attr_accessor :points

    def initialize(vertix)
      @points = vertix.map do |lat, long|
        Point(lat, long)
      end

      @polygon = Polygon.new(@points)
    end

    def surrounding?(lat, long)
      point = Point(lat, long)
      @polygon.contains?(point)
    end
  end
end
