require 'bundler/setup'
require 'active_support'
require 'active_support/testing/autorun'

require 'active_model/aggregator'

ActiveSupport::TestCase.test_order = :random

module Record
  class Base
    include ActiveModel::Model

    def save
      models[self.class] += 1
    end

    class << self
      alias :build :new

      def count
        models[self]
      end
    end

    private
      mattr_reader(:models) { Hash.new { |h,k| h[k] = 0 } }
  end
end

require 'models/person'
require 'models/email'
require 'aggregators/profile.rb'
