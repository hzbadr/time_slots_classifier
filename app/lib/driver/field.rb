module Driver
  class Field
    attr_reader :lats, :longs
    def initialize(polygon_lats, polygon_longs)
      @lats = polygon_lats
      @longs = polygon_longs
    end

    def surrounding?(lat, long)
      lat >= lats.min && lat <= lats.max &&
        long >= longs.min && long <= longs.max
    end
  end
end