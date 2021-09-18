# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_18_000635) do

  create_table "unsubscribe_mailer_subscriptions", force: :cascade do |t|
    t.integer "owner_id", null: false
    t.boolean "subscribed"
    t.string "mailer", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_unsubscribe_mailer_subscriptions_on_owner_id"
  end

  add_foreign_key "unsubscribe_mailer_subscriptions", "owners"
end
