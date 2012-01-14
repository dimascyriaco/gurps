module Gurps
  class Character
    attr_accessor :strength, :dexterity, :intelligence, :health

    def initialize(points = 100)
      @strength = @dexterity = @intelligence = @health = 10
    end

    def basic_lift
      @strength * @strength
    end

    def points_to_spend
      100
    end
  end
end