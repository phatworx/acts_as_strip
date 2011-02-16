require 'rubygems'
require 'active_record'

# Plugin to remove spaces on fields
module ActsAsStrip

  def self.included(base) # :nodoc:
    base.extend ClassMethods
  end

  # class methods for active record and active model
  module ClassMethods

    # activate gem on ar-model to trim spaces on fields
    #
    # -----
    #
    # === Example:
    #   class User < ActiveRecord::Base
    #     acts_as_strip :field1, :field2
    #   end
    #
    def acts_as_strip(*fields)
      include InstanceMethods
      cattr_accessor :strip_fields
      self.strip_fields = fields
      before_validation :strip_fields! if self.respond_to? :before_validation
    end

  end

  # instance methods for active record and active model
  module InstanceMethods
    # strip declared fields
    #
    # ----
    #
    # === Example:
    # User.new(data).strip_fields!
    def strip_fields!
      strip_fields.each do |n|
        send("#{n}=", send("#{n}").strip) if send("#{n}").respond_to?('strip')
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActsAsStrip) if defined? ActiveRecord
