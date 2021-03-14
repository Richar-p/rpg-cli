module Database
  def init_database
    db = SQLite3::Database.new @database_path

    db.execute "create table heros (id INTEGER PRIMARY KEY, name VARCHAR(55), level INTEGER, life INTEGER, food INTEGER, thirst INTEGER);"

    db.close
  end
end
