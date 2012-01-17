module Gurps
  class Table
    attr_accessor :name, :data, :attribute, :columns

    def initialize yml_file
      $tables ||= {}
      yml = YAML::load_file(File.open(yml_file))
      @name = yml.keys.first.downcase
      @attribute = yml[@name]['headers'].shift
      @columns = yml[@name]['headers']
      @data = yml[@name]['data']
      $tables[@name] = self
    end

    def get_value_for_column(column, value)
      @data[value][@columns.index(column)]
    end

    def empty?
      @data.empty?
    end

    def self.[](value)
      $tables[value]
    end
  end
end