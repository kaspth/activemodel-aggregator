module Accessors
  extend ActiveSupport::Concern

  class_methods do
    private
      def define_accessors(name, klass)
        define_method(name) { instance_eval "@#{name} ||= #{klass}.new" }
        define_method("#{name}=") { |v| instance_variable_set("@#{name}", v) }
        define_method("#{name}_attributes") { model_attrs[name] }

        klass.attributes.each do |attr|
          delegate attr, to: name, prefix: true

          define_method "#{name}_#{attr}=" do |v|
            model_attrs[name][attr] = v
            send(name).send("#{attr}=", v)
          end
        end
      end
  end

  private
    def model_attrs
      @model_attrs ||= Hash.new { |h,k| h[k] = {} }
    end
end