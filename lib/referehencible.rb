require 'referehencible/version'

module Referehencible
  def self.included(base)
    base.class_eval do
      ###
      # Validations
      #
      validates       :guid,
                        presence:         true,
                        uniqueness:       true,
                        length:           {
                          is:               16 }

      ###
      # Hooks
      #
      before_create   :generate_guid

      ###
      # ActiveRecord Overrides
      #
      def guid; generate_guid; end
    end
  end

private
  def generate_guid
    read_attribute(:guid) || write_attribute('guid', SecureRandom.hex(8))
  end
end
