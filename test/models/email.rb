class Email < Record::Base
  attr_accessor :address

  def self.attribute_names
    [:address]
  end
end
