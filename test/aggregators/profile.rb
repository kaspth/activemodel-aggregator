class Profile < ActiveModel::Aggregator
  aggregate :person
  aggregate :email

  def combine
    person.save
    person.emails.build(email_attributes).save
  end
end
