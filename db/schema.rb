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

ActiveRecord::Schema.define(:version => 20111227005015) do

  create_table "answer_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "answer_id"
    t.integer  "result"
    t.boolean  "fav"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.string   "question"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", :force => true do |t|
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "results"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
