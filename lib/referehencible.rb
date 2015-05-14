require 'referehencible/version'
require 'securerandom'

module Referehencible
  DEFAULT_LENGTH = 36

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
  module ClassMethods
    def referenced_by(*referenced_attrs)
      default_options = {
        length: DEFAULT_LENGTH,
        type:   :uuid,
      }

      referenced_attrs = \
        referenced_attrs.each_with_object({}) do |referenced_attr, transformed_attr|
          case referenced_attr
          when Symbol
            transformed_attr[referenced_attr] = default_options
          when Hash
            transformed_attr.merge! referenced_attr
          end
        end

      referenced_attrs.each do |reference_attribute, options|
        validates reference_attribute,
                  presence:   true,
                  uniqueness: true,
                  format:     {
                    with:             /[a-f0-9\-]{#{options[:length]}}/ },
                  length:     {
                    is:               options[:length] }

        define_method(reference_attribute) do
          send("generate_#{options[:type]}_guid",
               reference_attribute,
               options[:length])
        end

        define_singleton_method("by_#{reference_attribute}") do |guid_to_find|
          where(:"#{reference_attribute}" => guid_to_find).
            first ||
            unknown_reference_object
        end

        after_initialize(lambda do
          send("generate_#{options[:type]}_guid",
               reference_attribute,
               options[:length])
        end)
      end

      private

      define_method(:generate_hex_guid) do |reference_attribute, length|
        hex_length = (length / 2.0 + 1).floor

        read_attribute(reference_attribute) ||
        write_attribute(reference_attribute,
                        SecureRandom.hex(hex_length).slice(0, length))
      end

      define_method(:generate_uuid_guid) do |reference_attribute, _length|
        read_attribute(reference_attribute) || write_attribute(reference_attribute,
                                                               SecureRandom.uuid)
      end

      define_singleton_method(:unknown_reference_object) do
        return new unless respond_to?(:as_null_object)

        as_null_object
      end
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength

  def self.included(base)
    base.extend ClassMethods
  end
end
