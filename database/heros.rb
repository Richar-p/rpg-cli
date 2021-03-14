# SQL Query to create a hero by his name
def create_hero(name)
  db = SQLite3::Database.new @database_path

  db.execute "insert into heros values (NULL, \"#{name}\", 1, 100, 100, 100)"
end

# SQL Query to get all heros
def get_heros
  db = SQLite3::Database.open @database_path

  stm = db.prepare "SELECT * FROM Heros ORDER BY id DESC"
  stm.execute
end

# SQL Query to get a hero by his id
def get_hero(id)
  db = SQLite3::Database.open @database_path

  stm = db.prepare "SELECT * FROM Heros WHERE id = #{id} LIMIT(1)"
  rs = stm.execute

  rs.first
end

# SQL Query to remove a hero by his id
def remove_hero(id)
  db = SQLite3::Database.open @database_path

  db.execute "DELETE FROM Heros WHERE id = #{id}"
end