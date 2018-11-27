require_relative 'database/database'
require 'byebug'

class BaseObject
  include Database
  attr_accessor :id, :created_at

  def initialize(params = {})
    self.class.columns.each do |column|
      self.send("#{column}=", params[column])
    end
  end

  def to_hash
    {}.tap do |hash|
      instance_variables.each do |var|
        hash[var.to_s.delete("@")] = instance_variable_get(var)
      end
    end
  end

  def save
    insert(self).nil? ? false : true
  end

  def tableize
    self.class.to_s.downcase + 's'
  end

  class << self
    def all
      results = Database.all(self)
      parse_all(results)
    end

    def tableize
      self.to_s.downcase + 's'
    end

    def parse_all(results)
      results[1..-1].map do |result|
        new(result)
      end
    end

    def columns
      Database.columns(self)
    end
  end
end
