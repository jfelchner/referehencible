require 'referehencible/version'

module Referehencible
  def self.included(base)
    base.class_eval do
      ###
      # Validations
      #
      validates       :reference_number,
                        presence:         true,
                        uniqueness:       true,
                        length:           {
                          is:               16 }

      ###
      # Hooks
      #
      before_create   :generate_reference_number

      ###
      # ActiveRecord Overrides
      #
      def reference_number; generate_reference_number; end
    end
  end

private
  def generate_reference_number
    read_attribute(:reference_number) || write_attribute('reference_number', SecureRandom.hex(8))
  end
end
