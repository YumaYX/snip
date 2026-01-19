require "active_record"
require "logger"

ActiveRecord::Base.logger = Logger.new(STDOUT)

# DB作成
ActiveRecord::Base.establish_connection(
  adapter:  "sqlite3",
  database: "sample.db"
)

# テーブル作成
ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string  :name
    t.integer :age
    t.timestamps
  end

  create_table :products, force: true do |t|
    t.string  :name
    t.integer :price
    t.timestamps
  end
end

# モデル定義
class User < ActiveRecord::Base
self.primary_key = "name"
end

class Product < ActiveRecord::Base; end

# users データ
User.create!(name: "Taro", age: 20)
User.create!(name: "Hanako", age: 22)
User.create!(name: "Jiro", age: 25)

# products データ（違う種類のデータ）
Product.create!(name: "Apple",  price: 120)
Product.create!(name: "Orange", price: 150)
Product.create!(name: "Banana", price: 100)

puts "完了：users と products にデータを投入しました"
