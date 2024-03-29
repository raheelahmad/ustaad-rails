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

ActiveRecord::Schema.define(:version => 20130113044226) do

  create_table "cards", :force => true do |t|
    t.string   "question"
    t.string   "answer"
    t.integer  "topic_id"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "answer_image_file_name"
    t.string   "answer_image_content_type"
    t.integer  "answer_image_file_size"
    t.datetime "answer_image_updated_at"
    t.boolean  "public",                      :default => false
    t.string   "question_image_file_name"
    t.string   "question_image_content_type"
    t.integer  "question_image_file_size"
    t.datetime "question_image_updated_at"
  end

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "remember_token"
    t.string   "name"
  end

end
