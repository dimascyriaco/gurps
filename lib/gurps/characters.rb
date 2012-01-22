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

    # @return [Numeric]
    def lifting
      @strength * @strength
    end

    # @return [Numeric]
    def basic_lift
      # TODO implementar home gravity (p.17)
      (lifting / 5).floor
    end

    # @return [String]
    def thrust_damage
      Table['damage'].get_value_for_column('Thrust', strength)
    end
    alias_method :thr, :thrust_damage

    # @return [String]
    def swing_damage
      Table['damage'].get_value_for_column('Swing', strength)
    end
    alias_method :sw, :swing_damage

    # @return [String]
    def damage
      thrust_damage + "/" + swing_damage
    end
    alias_method :dmg, :damage

    # @return [Numeric]
    def hit_points
      health
    end
    alias_method :hp, :hit_points

    # @return [Numeric]
    def will
      intelligence
    end

    # @return [Numeric]
    def perception
      intelligence
    end
    alias_method :per, :perception

    # @return [Numeric]
    def fatigue
      # TODO tratar machines (p.16)
      health
    end
    alias_method :fat, :fatigue

    # @return [Numeric]
    def basic_speed
      (strength + dexterity).to_f / 4
    end

    # @return [Numeric]
    def dodge
      (basic_speed + 3).floor - encumbrance_level
    end

    # @return [Numeric]
    def basic_move
      basic_speed.floor
    end

    # @return [Numeric]
    def move
      basic_move * move_modificator
    end

    # @return [Numeric]
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

    # @return [Numeric]
    def weight
      ((strength - 6) * 15) + 90
    end

    # @param advantage [String]
    # @return [NilClass]
    def buy(advantage)
      advantage = Gurps::Advantage[advantage]
      @points_to_spend += advantage.cost.to_i
      self.register_modifiers advantage.modifiers
    end

    # @param modifiers [Array]
    def register_modifiers modifiers
      @modifiers ||= []
      @modifiers = @modifiers | modifiers
    end

    # @param attribute [String]
    # @return [Array]
    def modifiers_for attribute
      @modifiers.select {|e| e.target.to_sym == attribute }
    end

    private

    # @return [Numeric]
    def move_modificator
      (1.to_f - ((encumbrance_level) * 0.2)).round(1)
    end

    class Modifier < OpenStruct

    end
  end
end
