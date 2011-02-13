class ActiveRecordDummy < ActiveRecord::Base
  class_inheritable_accessor :columns
  self.columns = []

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  column :field1, :string
  column :field2, :string

  acts_as_strip :field1, :field2
end

class ActiveModelDummy
  include ActsAsStrip

  attr_accessor :field1
  attr_accessor :field2
  
  acts_as_strip :field1, :field2
end


