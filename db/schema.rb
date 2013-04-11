# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130210190535) do

  create_table "atms", :force => true do |t|
    t.string  "branch",          :limit => 256
    t.integer "municipality_id",                :null => false
    t.string  "street",          :limit => 256
    t.string  "district",        :limit => 256
    t.string  "zipcode",         :limit => 5
    t.float   "latitude",                       :null => false
    t.float   "longitude",                      :null => false
    t.integer "bank_id",                        :null => false
  end

  add_index "atms", ["latitude", "longitude", "bank_id"], :name => "lat_lon_bank", :unique => true

  create_table "banks", :force => true do |t|
    t.string "name", :limit => 64, :null => false
  end

  create_table "municipalities", :force => true do |t|
    t.string  "name",      :limit => 256, :null => false
    t.integer "state_id",                 :null => false
    t.float   "latitude"
    t.float   "longitude"
  end

  create_table "reports", :force => true do |t|
    t.integer "atm_id",                     :null => false
    t.integer "type_id",                    :null => false
    t.date    "reported_at"
    t.integer "status",      :default => 0
  end

  create_table "states", :force => true do |t|
    t.string  "name",      :limit => 64, :null => false
    t.string  "code",      :limit => 2
    t.float   "latitude"
    t.float   "longitude"
    t.float   "zoom"
    t.integer "space"
  end

  create_table "users", :force => true do |t|
    t.string "username",        :null => false
    t.string "password_digest"
  end

end
