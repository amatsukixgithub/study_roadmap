# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_02_141827) do

  create_table "roadmap_details", force: :cascade do |t|
    t.integer "roadmap_header_id", null: false
    t.text "sub_title"
    t.text "pic_pass1"
    t.text "pic_pass2"
    t.text "pic_pass3"
    t.text "pic_pass4"
    t.integer "time_required"
    t.integer "time_required_unit"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["roadmap_header_id"], name: "index_roadmap_details_on_roadmap_header_id"
  end

  create_table "roadmap_headers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "title"
    t.text "assumption_level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "created_at"], name: "index_roadmap_headers_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_roadmap_headers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "comment"
    t.string "icon_pass"
    t.string "web_page"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "roadmap_details", "roadmap_headers"
  add_foreign_key "roadmap_headers", "users"
end
