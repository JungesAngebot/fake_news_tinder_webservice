module Tombstoning
  extend ActiveSupport::Concern

  included do
    default_scope { where(tombstone: false) }

    def destroy
      raise "#{self.class.name} must have attribute tombstone" unless self.has_attribute?(:tombstone)
      raise "Column tombstone in #{self.class.name} must be a boolean" unless self.class.columns_hash['tombstone'].type
      self.tombstone = true

      self.run_callbacks(:destroy)

      self.save(validate: false)
    end

  end

  module ClassMethods
    def validates_uniqueness_of(*attr_names)
      if attr_names[-1].is_a? Hash
        attr_names[-1].merge!(conditions: -> { where(tombstone: false) })
      else
        attr_names << {conditions: -> { where(tombstone: false) }}
      end
      validates_with ActiveRecord::Validations::UniquenessValidator, _merge_attributes(attr_names)
    end
  end
end