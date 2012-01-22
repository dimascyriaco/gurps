require 'yaml'
require 'ostruct'

Dir[File.join(File.expand_path(File.dirname(__FILE__)), 'gurps/**/*.rb')].each { |f| require f }
Dir[File.join(File.expand_path(File.dirname(__FILE__)), 'gurps/**/*_table.yml')].each { |t| Gurps::Table.new t }
Dir[File.join(File.expand_path(File.dirname(__FILE__)), 'gurps/**/*_advantages.yml')].each { |t| Gurps::Advantage.load t }