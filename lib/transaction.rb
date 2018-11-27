require_relative 'base_object'

class Transaction < BaseObject
  attr_accessor :amount

  def initialize(args = {})
    super(args)
  end
end
