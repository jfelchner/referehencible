require 'referehencible/version'
require 'securerandom'

module Referehencible
  module ClassMethods
    def referenced_by(*referenced_attributes)
      referenced_attributes.each do |reference_attribute|
        validates       reference_attribute,
                          presence:         true,
                          uniqueness:       true,
                          format:           {
                            with:             /[a-f0-9]{32}/ },
                          length:           {
                            is:               32 }

        define_method(reference_attribute) do
          generate_guid(reference_attribute)
        end

        define_singleton_method("by_#{reference_attribute}") do |guid_to_find|
          where(:"#{reference_attribute}" => guid_to_find).
          first ||
          unknown_reference_object
        end

        after_initialize lambda { generate_guid reference_attribute }
      end

      private

      define_method(:generate_guid) do |reference_attribute|
        read_attribute(reference_attribute) || write_attribute(reference_attribute, Referehencible.reference_number)
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

  def self.reference_number
    SecureRandom.hex(16)
  end
end
