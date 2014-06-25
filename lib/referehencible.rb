require 'referehencible/version'
require 'securerandom'

module Referehencible
  DEFAULT_LENGTH = 36

  module ClassMethods
    def referenced_by(*referenced_attributes)
      default_options = {
        length: DEFAULT_LENGTH,
        type:   :uuid,
      }

      referenced_attributes = referenced_attributes.each_with_object({}) do |referenced_attribute, transformed_attributes|
                                case referenced_attribute
                                when Symbol
                                  transformed_attributes[referenced_attribute] = default_options
                                when Hash
                                  transformed_attributes.merge! referenced_attribute
                                end
                              end

      referenced_attributes.each do |reference_attribute, options|
        raise RuntimeError, "You attempted to pass in a length of #{options[:length]} for #{reference_attribute} in #{self.name}. Only even numbers are allowed." \
          if options[:length].odd?

        validates       reference_attribute,
                          presence:         true,
                          uniqueness:       true,
                          format:           {
                            with:             /[a-f0-9\-]{#{options[:length]}}/ },
                          length:           {
                            is:               options[:length] }

        define_method(reference_attribute) do
          send("generate_#{options[:type]}_guid", reference_attribute, options[:length] / 2)
        end

        define_singleton_method("by_#{reference_attribute}") do |guid_to_find|
          where(:"#{reference_attribute}" => guid_to_find).
          first ||
          unknown_reference_object
        end

        after_initialize lambda { send("generate_#{options[:type]}_guid", reference_attribute, options[:length] / 2) }
      end

      private

      define_method(:generate_hex_guid) do |reference_attribute, length|
        read_attribute(reference_attribute) || write_attribute(reference_attribute, SecureRandom.hex(length))
      end

      define_method(:generate_uuid_guid) do |reference_attribute, length|
        read_attribute(reference_attribute) || write_attribute(reference_attribute, SecureRandom.uuid)
      end

      define_singleton_method(:unknown_reference_object) do
        return new unless respond_to?(:as_null_object)

        as_null_object
      end
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end
end
