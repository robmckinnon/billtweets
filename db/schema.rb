# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090519174350) do

  create_table "bills", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.string   "feed_uri"
    t.integer  "tweeter_id"
    t.string   "house"
    t.string   "bill_type"
    t.text     "categories"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bills", ["tweeter_id"], :name => "index_bills_on_tweeter_id"

  create_table "entry_items", :force => true do |t|
    t.string   "title"
    t.string   "type"
    t.string   "url"
    t.string   "publisher"
    t.string   "published_date"
    t.datetime "published_time"
    t.text     "content"
    t.integer  "entry_query_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entry_source_id"
  end

  add_index "entry_items", ["entry_query_id"], :name => "index_entry_items_on_entry_query_id"
  add_index "entry_items", ["entry_source_id"], :name => "index_entry_items_on_entry_source_id"

  create_table "entry_queries", :force => true do |t|
    t.string   "type"
    t.integer  "bill_id"
    t.string   "feed_uri"
    t.string   "query"
    t.string   "site_restriction"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entry_queries", ["bill_id"], :name => "index_entry_queries_on_bill_id"

  create_table "entry_sources", :force => true do |t|
    t.string   "type"
    t.string   "author_uri"
    t.string   "author_name"
    t.string   "item_host_uri"
    t.string   "item_title_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outgoing_tweets", :force => true do |t|
    t.string   "dm_to"
    t.string   "reply_to"
    t.string   "message"
    t.boolean  "tweeted"
    t.datetime "tweeted_at"
    t.integer  "tweeter_id"
    t.integer  "tweet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "outgoing_tweets", ["tweet_id"], :name => "index_outgoing_tweets_on_tweet_id"
  add_index "outgoing_tweets", ["tweeter_id"], :name => "index_outgoing_tweets_on_tweeter_id"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope",          :limit => 40
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "scope", "sequence"], :name => "index_slugs_on_name_and_sluggable_type_and_scope_and_sequence", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "tweeters", :force => true do |t|
    t.string   "name"
    t.string   "full_name"
    t.string   "url"
    t.string   "bio"
    t.string   "password"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", :force => true do |t|
    t.string   "dm_to"
    t.string   "reply_to"
    t.string   "message"
    t.boolean  "tweeted"
    t.datetime "tweeted_at"
    t.integer  "tweeter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entry_item_id"
  end

  add_index "tweets", ["tweeter_id"], :name => "index_tweets_on_tweeter_id"

end
