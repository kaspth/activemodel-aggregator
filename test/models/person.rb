class Person < Record::Base
  attr_accessor :name

  def self.attribute_names
    [:name]
  end

  def emails
    Email
  end
end
