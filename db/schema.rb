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

ActiveRecord::Schema.define(version: 2018_12_07_162001) do

  create_table "applicationroles", primary_key: "applicationroleid", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "applicationrolename", limit: 45
  end

  create_table "applicationuserinroles", primary_key: "applicationuserinroleid", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "applicationuser_id"
    t.integer "applicationrole_id"
    t.index ["applicationrole_id"], name: "applicationroleid_idx"
    t.index ["applicationuser_id"], name: "applicationuserid_idx"
  end

  create_table "applicationusers", primary_key: "applicationuserid", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "email", limit: 100
    t.string "password_digest", limit: 100
    t.string "salt", limit: 45
    t.string "firstname", limit: 45
    t.string "lastname", limit: 45
    t.index ["email"], name: "email_UNIQUE", unique: true
  end

  create_table "courses", primary_key: "courseid", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", limit: 100
    t.string "description", limit: 500
  end

  create_table "coursesforroles", primary_key: "coursesforroleid", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "course_id"
    t.integer "role_id"
    t.index ["course_id"], name: "courseid_idx"
    t.index ["role_id"], name: "roleid_idx"
  end

  create_table "courseversions", primary_key: "courseversionid", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "course_id"
    t.integer "version_id"
    t.index ["course_id"], name: "courseid_idx"
    t.index ["version_id"], name: "versionid_idx"
  end

  create_table "employeeroles", primary_key: "employeerolesid", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "employee_id"
    t.integer "role_id"
    t.index ["employee_id"], name: "employeeid_idx"
    t.index ["role_id"], name: "rolesid_idx"
  end

  create_table "employees", primary_key: "employeeid", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "firstname", limit: 45
    t.string "lastname", limit: 45
    t.string "primaryemail", limit: 45
    t.boolean "isactive"
  end

  create_table "eventattendees", primary_key: "eventattendeesid", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "trainingevent_id"
    t.integer "employee_id"
    t.index ["employee_id"], name: "attendeeid_idx"
    t.index ["trainingevent_id"], name: "eventid_idx"
  end

  create_table "roles", primary_key: "rolesid", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "rolename", limit: 45
  end

  create_table "trainingevents", primary_key: "trainingeventid", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "trainingeventname", limit: 50
    t.integer "courseversionid"
    t.datetime "eventdatetime"
    t.string "signupsheet", limit: 500
  end

  create_table "versions", primary_key: "versionid", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "versionname", limit: 45
    t.datetime "createddatetime", default: -> { "CURRENT_TIMESTAMP" }
  end

  add_foreign_key "applicationuserinroles", "applicationroles", primary_key: "applicationroleid", name: "applicationroleid"
  add_foreign_key "applicationuserinroles", "applicationusers", primary_key: "applicationuserid", name: "applicationuserid"
  add_foreign_key "coursesforroles", "courses", primary_key: "courseid", name: "coursesid"
  add_foreign_key "coursesforroles", "roles", primary_key: "rolesid", name: "roleid"
  add_foreign_key "courseversions", "courses", primary_key: "courseid", name: "courseid"
  add_foreign_key "courseversions", "versions", primary_key: "versionid", name: "versionid"
  add_foreign_key "employeeroles", "employees", primary_key: "employeeid", name: "employeeid"
  add_foreign_key "employeeroles", "roles", primary_key: "rolesid", name: "rolesid"
  add_foreign_key "eventattendees", "employees", primary_key: "employeeid", name: "employee_id"
  add_foreign_key "eventattendees", "trainingevents", primary_key: "trainingeventid", name: "trainingevent_id"
end
