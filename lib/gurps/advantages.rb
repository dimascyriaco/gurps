module Gurps
  class Advantage
    @@advantages = {}

    def initialize attr
      @attr = attr
    end

    # @param name [String]
    # @return [Gurps::Advantage]
    def self.[](name)
      @@advantages[name]
    end

    # @param hash [Hash]
    # @return [NilClass]
    def self.register hash
      hash.recursively_symbolize_keys!
      key = hash.keys.first
      hash[key][:modifiers] = generate_modifiers(hash[key])
      @@advantages[key] = self.new(hash[key])
    end

    # @return [Array]
    def self.available
      @@advantages.keys
    end

    # @param file [File]
    # @return [NilClass]
    def self.load file
      yml = YAML.load_file file
      yml.each do |name, properties|
        register name => properties
      end
    end

    def method_missing name, *args
      return @attr[name] if @attr.include? name
      super name, *args
    end

    def self.method_missing name, *args
      return @@advantages[name] if @@advantages.include? name
      super name, *args
    end

    private

    # @param hash [Hash]
    # @return [Hash]
    def self.generate_modifiers hash
      modifiers = hash.delete :modifiers
      modifiers.map { |m| Gurps::Character::Modifier.new(m) } if modifiers
    end
  end
end