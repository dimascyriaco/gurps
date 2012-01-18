module Gurps
  class Character
    attr_accessor :strength, :dexterity, :intelligence, :health, :encumbrance, :height, :weight, :points_to_spend

    alias_method :st, :strength
    alias_method :dx, :dexterity
    alias_method :iq, :intelligence
    alias_method :ht, :health

    def initialize(points = 100)
      @strength = @dexterity = @intelligence = @health = 10
      @encumbrance = 0
      @points_to_spend = points
    end

    def lifting
      @strength * @strength
    end

    def basic_lift
      # TODO implementar home gravity (p.17)
      (lifting / 5).floor
    end

    def thrust_damage
      Table['damage'].get_value_for_column('Thrust', strength)
    end
    alias_method :thr, :thrust_damage

    def swing_damage
      Table['damage'].get_value_for_column('Swing', strength)
    end
    alias_method :sw, :swing_damage

    def damage
      thrust_damage + "/" + swing_damage
    end
    alias_method :dmg, :damage

    def hit_points
      health
    end
    alias_method :hp, :hit_points

    def will
      intelligence
    end

    def perception
      intelligence
    end
    alias_method :per, :perception

    def fatigue
      # TODO tratar machines (p.16)
      health
    end
    alias_method :fat, :fatigue

    def basic_speed
      (strength + dexterity).to_f / 4
    end

    def dodge
      (basic_speed + 3).floor - encumbrance_level
    end

    def basic_move
      basic_speed.floor
    end

    def move
      basic_move * move_modificator
    end

    def encumbrance_level
      case encumbrance
        when 0..basic_lift
          0
        when basic_lift..(basic_lift*2)
          1
        when (basic_lift * 2)..(basic_lift * 3)
          2
        when (basic_lift * 3)..(basic_lift * 6)
          3
        when (basic_lift * 6)..(basic_lift * 10)
          4
      end
    end

    def weight
      ((strength - 6) * 15) + 90
    end

    def buy(advantage)
      @points_to_spend += Gurps::Advantage[advantage][:cost]
    end

    private

    def move_modificator
      (1.to_f - ((encumbrance_level) * 0.2)).round(1)
    end
  end
end
