module Gurps
  class Campaign
    attr_accessor :starting_points, :disadvantage_limit

    def initialize
      @starting_points = 100
      @disadvantage_limit = (starting_points / 2).floor
    end
  end
end