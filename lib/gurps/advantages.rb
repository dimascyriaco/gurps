module Gurps
  class Advantage
    def self.available
      $advantages ||= {skinny: {cost: -5, modifiers: {weight: {level: '*2/3'}, disguise: {level: '-2'}, shadowing: {level: '-2'}, health: {upper_limit: '14'}}, secondary_effects: {strength: {level: '-2', situation: 'resist knockback'}}}}
      $advantages.keys
    end

    def self.[](name)
      $advantages[name]
    end
  end
end