require "active_record"
require "logger"

ActiveRecord::Base.logger = Logger.new(STDOUT)

# DB作成
ActiveRecord::Base.establish_connection(
  adapter:  "sqlite3",
  database: "sample.db"
)

tables = ActiveRecord::Base.connection.tables

tables.each do |table|
  class_name = table.classify

  klass = Class.new(ActiveRecord::Base) do
    self.table_name = table
    self.inheritance_column = :_type_disabled # STI対策（必要なら）
  end

  Object.const_set(class_name, klass)
end

User.all.each do |u|
  puts "#{u.name} #{u.age}"
end

Product.all.each do |pr|
  puts "#{pr.name} #{pr.price}"
end
