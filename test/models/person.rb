class Person < Record::Base
  attr_accessor :name

  def self.attributes
    [:name]
  end

  def emails
    Email
  end
end
