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

ActiveRecord::Schema.define(:version => 20120717022611) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "nickname"
    t.string   "token"
  end

  add_index "authentications", ["provider"], :name => "index_authentications_on_provider"
  add_index "authentications", ["uid"], :name => "index_authentications_on_uid"
  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "location"
    t.decimal  "minimum_raise"
    t.text     "description"
    t.string   "slug"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.datetime "event_time"
    t.datetime "raise_end"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "request_video"
    t.string   "proof_video"
    t.string   "image"
  end

  add_index "events", ["slug"], :name => "index_events_on_slug", :unique => true
  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "followings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "followable_id"
    t.string   "followable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "followings", ["followable_id"], :name => "index_followings_on_followable_id"
  add_index "followings", ["followable_type"], :name => "index_followings_on_followable_type"
  add_index "followings", ["user_id", "followable_id", "followable_type"], :name => "index_followings_on_all", :unique => true

  create_table "profiles", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "user_id"
    t.text     "about"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
  end

  add_index "profiles", ["user_id"], :name => "index_profiles_on_user_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "slug"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true

end
