module Gurps
  class Character
    include Abilitude::Character

    attr_accessor :strength, :dexterity, :intelligence, :health, :encumbrance, :height, :points

    alias_method :st, :strength
    alias_method :dx, :dexterity
    alias_method :iq, :intelligence
    alias_method :ht, :health

    def initialize(points = 100)
      @strength = @dexterity = @intelligence = @health = 10
      @encumbrance = 0
      @points = points
    end

    attribute :basic_lift do
      # TODO implement home gravity (p.17)
      (lifting / 5).floor
    end

    attribute :thrust_damage, :thr do
      Table['damage'].get_value_for_column('Thrust', strength)
    end

    attribute :lifting do
      strength * strength
    end

    attribute :weight do
      (((strength - 6) * 15) + 90)
    end

    # @return [String]
    attribute :swing_damage, :sw do
      Table['damage'].get_value_for_column('Swing', strength)
    end

    # @return [String]
    attribute :damage, :dmg do
      thrust_damage + "/" + swing_damage
    end

    # @return [Numeric]
    attribute :hit_points, :hp do
      health
    end

    # @return [Numeric]
    attribute :will do
      intelligence
    end

    # @return [Numeric]
    attribute :perception, :per do
      intelligence
    end

    # @return [Numeric]
    attribute :fatigue, :fat do
      # TODO treat machines (p.16)
      health
    end

    # @return [Numeric]
    attribute :basic_speed do
      (strength + dexterity).to_f / 4
    end

    # @return [Numeric]
    attribute :dodge do
      (basic_speed + 3).floor - encumbrance_level
    end

    # @return [Numeric]
    attribute :basic_move do
      basic_speed.floor
    end

    # @return [Numeric]
    attribute :move do
      basic_move * move_modifier
    end

    # @return [Numeric]
    attribute :encumbrance_level do
      case encumbrance
        when 0..basic_lift
          0
        when basic_lift..(basic_lift*2)
          1
        when (basic_lift * 2)..(basic_lift * 3)
          2
        when (basic_lift * 3)..(basic_lift * 6)
          3
        else
          4
      end
    end

    private

    # @return [Numeric]
    def move_modifier
      (1.to_f - ((encumbrance_level) * 0.2)).round(1)
    end

    class Modifier < OpenStruct
      def apply(attribute)
        integer, fraction = value.split('/')

        if type == 'multiplier'
          attribute = attribute * (integer.to_f / fraction.to_i)
        end
        attribute
      end
    end
  end
end
