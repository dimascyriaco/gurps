module Gurps
  class Advantage
    def self.available
      $advantages ||= {:skinny => {cost: -5}}
      $advantages.keys
    end

    def self.[](name)
      $advantages[name]
    end
  end
end