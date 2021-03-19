# SQL Queries to create and init database
def init_database
  db = SQLite3::Database.new @database_path

  db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS heros (
      id INTEGER PRIMARY KEY, 
      name VARCHAR(55), 
      level FLOAT, 
      life INTEGER, 
      food INTEGER, 
      thirst INTEGER,
      attack_start_time TIME NULL,
      attack_end_time TIME NULL,
      attack_type VARCHAR(10) NULL
    );
  SQL
end
