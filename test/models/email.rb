class Email < Record::Base
  attr_accessor :address

  def self.attributes
    [:address]
  end
end
