require 'referehencible/version'
require 'securerandom'

# rubocop:disable Metrics/LineLength, Metrics/PerceivedComplexity
module Referehencible
  DEFAULT_LENGTH = 36

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
  module ClassMethods
    def referenced_by(*referenced_attrs)
      default_options = {
        length: DEFAULT_LENGTH,
        type:   :uuid,
      }

      referenced_attrs = referenced_attrs.each_with_object({}) do |referenced_attr, transformed_attr|
          case referenced_attr
          when Symbol
            transformed_attr[referenced_attr] = default_options
          when Hash
            transformed_attr.merge! referenced_attr
          end
      end

      referenced_attrs.each do |reference_attribute, options|
        if respond_to?(:validates)
          validates reference_attribute,
                    presence: true,
                    format:   {
                      with: /[a-zA-Z0-9\-_=]{#{options[:length]}}/,
                    },
                    length:   {
                      is: options[:length],
                    }
        end

        define_method(reference_attribute) do
          read_reference_attribute(reference_attribute) ||
          write_reference_attribute(reference_attribute, __send__("generate_#{options[:type]}_guid", options[:length]))
        end

        define_singleton_method("for_#{reference_attribute}") do |guid_to_find|
          where(:"#{reference_attribute}" => guid_to_find)
        end

        define_singleton_method("find_for_#{reference_attribute}") do |guid_to_find|
          where(:"#{reference_attribute}" => guid_to_find).first ||
          unknown_reference_object
        end

        next unless respond_to?(:after_initialize)
        after_initialize(lambda do
          __send__("generate_#{options[:type]}_guid",
                   reference_attribute,
                   options[:length])
        end)
      end

      private

      define_method(:generate_hex_guid) do |length|
        hex_length = (length / 2.0 + 1).floor

        SecureRandom.hex(hex_length).slice(0, length)
      end

      define_method(:generate_base64_guid) do |length|
        SecureRandom.urlsafe_base64(length).slice(0, length)
      end

      define_method(:generate_uuid_guid) do |_length|
        SecureRandom.uuid
      end

      define_method(:read_reference_attribute) do |reference_attribute|
        if respond_to?(:read_attribute)
          read_attribute(reference_attribute)
        else
          instance_variable_get("@#{reference_attribute}")
        end
      end

      define_method(:write_reference_attribute) do |reference_attribute, value|
        if respond_to?(:write_attribute)
          write_attribute(reference_attribute, value)
        else
          instance_variable_set("@#{reference_attribute}", value)
        end
      end

      define_singleton_method(:unknown_reference_object) do
        if respond_to?(:as_null_object)
          as_null_object
        else
          new
        end
      end
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength

  def self.included(base)
    base.extend ClassMethods
  end
end
# rubocop:enable Metrics/LineLength, Metrics/PerceivedComplexity
