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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170722182535) do

  create_table "stripe_charges", force: :cascade do |t|
    t.integer  "amount",             null: false
    t.string   "currency",           null: false
    t.string   "external_id",        null: false
    t.integer  "stripe_customer_id", null: false
    t.string   "status",             null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "stripe_customers", force: :cascade do |t|
    t.string   "first_name",  null: false
    t.string   "last_name",   null: false
    t.string   "email",   null: false
    t.string   "external_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
