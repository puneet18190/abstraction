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

ActiveRecord::Schema.define(version: 20170929070955) do

  create_table "chats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "userA_id"
    t.integer "userB_id"
    t.integer "userA_lastViewTime"
    t.integer "userB_lastViewTime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.string "description"
    t.bigint "price"
    t.string "text_price"
    t.string "amount_as_string"
    t.string "address"
    t.bigint "userIDHiring_id"
    t.string "workRequest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["userIDHiring_id"], name: "index_chores_on_userIDHiring_id"
  end

  create_table "feedback_to_moneys", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.string "invite_code"
    t.string "title"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "chat_id"
    t.integer "user_id"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "from_user"
    t.integer "to_user"
    t.bigint "amount"
    t.string "text_amo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "activity_name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "username"
    t.string "email"
    t.string "password"
    t.string "verify_email_code"
    t.boolean "is_email_verified"
    t.string "signup_code"
    t.string "invite_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "withdrawal_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "userID"
    t.bigint "amount"
    t.string "text_amo"
    t.string "information"
    t.string "type"
    t.string "processed_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "work_offers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "chore_id"
    t.integer "user_id"
    t.string "accept_offer_time"
    t.string "work_complete_time"
    t.string "work_complete_accepted_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chore_id"], name: "index_work_offers_on_chore_id"
  end

end
