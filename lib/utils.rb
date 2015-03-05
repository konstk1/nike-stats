module Utils

  # noinspection RubyClassVariableNamingConvention
  DAYS_OF_WEEK = %w(Su Mo Tu We Th Fr Sa)

  class << self

    def km_to_mi(km)
      km * 0.621371
    end

    def str_to_mins (str)
      # string format is hh:mm:ss.SSS
      str = str.split(':')
      60 * str[0].to_f + 1 * str[1].to_f + str[2].to_f/60
    end

    def down_to_nearest_half (x)
       (x - x.floor).round/2.0 + x.floor
    end

  end
end