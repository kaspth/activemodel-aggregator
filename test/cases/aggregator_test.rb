require 'helper'

class AggregatorTest < ActiveSupport::TestCase
  setup do
    @attrs = { person_name: 'Timm', email_address: 'test@example.com' }
    @profile = Profile.new(@attrs)
  end

  test "reader returns default object" do
    assert @profile.person
  end

  test "reader returns same object" do
    assert_equal @profile.person, @profile.person
  end

  test "prefixed accessor methods" do
    @profile.person_name = 'jjgittes'
    assert_equal 'jjgittes', @profile.person_name
  end

  test "profile save method combines person and email" do
    assert_difference ['Person.count', 'Email.count'] do
      @profile.save
    end
  end

  test "model scoped attributes" do
    exp = { address: 'test@example.com' }
    assert_equal exp, @profile.email_attributes
  end

  test "build a model from attributes" do
    email = @profile.person.emails.build @profile.email_attributes
    assert_equal 'test@example.com', email.address
  end

  test "setting a model" do
    @profile.person = Person.new(name: 'David')
    assert_equal 'David', @profile.person.name
  end
end

class Event < Record::Base
  attr_accessor :name

  validates_presence_of :name

  def self.attributes
    [:name]
  end
end

class AggregatorValidationTest < ActiveSupport::TestCase
  class Invite < ActiveModel::Aggregator
    aggregate :event
  end

  setup do
    @invite = Invite.new(event_name: 'Secret Meet')
  end

  test "valid" do
    assert @invite.valid?
  end

  test "invalid" do
    @invite.event_name = nil
    assert_not @invite.valid?
  end

  test "collects errors" do
    @invite.event_name = nil
    @invite.valid?

    assert_includes @invite.errors.first.full_messages, "Name can't be blank"
  end
end
