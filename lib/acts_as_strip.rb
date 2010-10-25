require 'rubygems'
require 'active_record'

module ActiveRecord #:nodoc:
  module ActsAsStrip #:nodoc:

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      # activate gem on ar-model to trim spaces on fields
      #
      # -----
      # 
      # === Example:
      #   class User
      #     acts_as_strip :field1, :field2
      #   end
      # 
      def acts_as_strip(*fields)
        before_validation do |model|
          fields.each do |n|
            model[n] = model[n].strip if model[n].respond_to?('strip')
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::ActsAsStrip)