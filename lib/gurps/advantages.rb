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

    # @param name [String]
    # @param attributes [Hash]
    # @return [NilClass]
    def self.register name, attributes
      attributes.recursively_symbolize_keys!
      attributes[:modifiers] = generate_modifiers(attributes)
      @@advantages[name.to_sym] = self.new(attributes)
    end

    # @return [Array]
    def self.available
      @@advantages.keys
    end

    # @param file [File]
    # @return [NilClass]
    def self.load file
      yml = YAML.load_file file
      yml.each do |name, attributes|
        register name, attributes
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
      hash[:modifiers].map { |m| Gurps::Character::Modifier.new(m) } if hash[:modifiers]
    end
  end
end