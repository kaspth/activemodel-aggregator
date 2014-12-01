require 'active_model'
require 'active_support/core_ext/module/delegation'

require 'active_model/aggregator/accessors'
require 'active_model/aggregator/aggregation'

module ActiveModel
  class Aggregator
    include Model
    include Aggregation
    include Accessors

    attr_reader :attributes

    def initialize(attributes = nil)
      @attributes = attributes

      assign_attributes(attributes)
    end

    aggregator_method :persisted?
    aggregator_method :valid?
    aggregator_method :combine

    def save
      combine if valid?
    end

    private
      def assign_attributes(attributes)
        attributes.each do |key, value|
          self.public_send("#{key}=", value)
        end if attributes
      end
  end
end
