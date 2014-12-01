require 'set'

module ActiveModel
  module Aggregation
    extend ActiveSupport::Concern

    class_methods do
      def aggregate(name)
        unless aggregates.include? name
          aggregates << name
          define_accessors(name, model_class_for(name))
        end
      end

      private
        def model_class_for(name)
          name.to_s.singularize.camelize.constantize
        end

        def aggregator_method(method_name)
          define_method method_name do
            aggregates.map { |a| send(a) }.all?(&method_name)
          end
        end

        def aggregates
          @aggregates ||= Set.new
        end
    end

    private
      def aggregates
        self.class.send(:aggregates)
      end
  end
end