module Database
  class Heros

    def create_hero(name)
      db = SQLite3::Database.new @database_path

      db.execute "insert into heros values (NULL, \"#{name}\", 1, 100, 100, 100)"

      db.close
    end

    def get_heros
      db = SQLite3::Database.open @database_path

      stm = db.prepare "SELECT * FROM Heros"
      rs = stm.execute

      db.close

      rs.each do |row|
        h = {
            id: row[0],
            name: row[1],
            level: row[2],
            food: row[3],
            thirst: row[4]
        }

        puts h.ai
      end
    end

    def get_hero(id)
      db = SQLite3::Database.open @database_path

      stm = db.prepare "SELECT * FROM Heros WHERE id = #{id}"
      rs = stm.execute

      db.close

      rs.each do |row|
        h = {
            id: row[0],
            name: row[1],
            level: row[2],
            food: row[3],
            thirst: row[4]
        }

        puts h.ai
      end
    end

    def remove_hero(id)
      db = SQLite3::Database.open @database_path

      db.execute "DELETE FROM Heros WHERE id = #{id}"

      db.close
    end
  end
end