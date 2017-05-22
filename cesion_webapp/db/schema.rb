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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170522022806) do

  create_table "ctds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "source"
    t.string   "source_rut"
    t.string   "destination"
    t.string   "destination_rut"
    t.datetime "transfer_date"
    t.integer  "folio"
    t.integer  "amount"
    t.string   "state"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.text     "doc",             limit: 65535
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "username",    limit: 65535
    t.text     "password",    limit: 65535
    t.string   "certificate"
    t.string   "private_key"
    t.text     "rut",         limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

end
