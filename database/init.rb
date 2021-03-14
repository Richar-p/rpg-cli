# SQL Queries to create and init database
def init_database
  db = SQLite3::Database.new @database_path

  db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS heros (
      id INTEGER PRIMARY KEY, 
      name VARCHAR(55), 
      level INTEGER, 
      life INTEGER, 
      food INTEGER, 
      thirst INTEGER
    );
  SQL
end
