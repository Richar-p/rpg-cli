# SQL Query to create a hero by his name
def create_hero(name)
  @db.execute "insert into heros values (NULL, \"#{name}\", 1, 100, 100, 100, NULL, NULL, NULL)"
end

# SQL Query to get all heros
def get_heros
  stm = @db.prepare "SELECT * FROM Heros ORDER BY id DESC"
  rows = stm.execute

  rows.map do |row|
    {
        id: row[0],
        name: row[1],
        level: row[2],
        life: row[3],
        food: row[4],
        thirst: row[5],
        attack_start_time: row[6].present? ? Time.at(row[6]).strftime("%e %m %Y - %H:%M:%S") : 'Nothing',
        attack_end_time: row[7].present? ? Time.at(row[7]).strftime("%e %m %Y - %H:%M:%S") : 'Nothing',
        attack_type: row[8].present? ? row[8] : 'Nothing'
    }
  end
end

# SQL Query to get a hero by his id
def get_hero(id)
  stm = @db.prepare "SELECT * FROM Heros WHERE id = #{id} LIMIT(1)"
  rs = stm.execute

  row = rs.first

  return nil if row.nil?

  {
    id: row[0],
    name: row[1],
    level: row[2],
    life: row[3],
    food: row[4],
    thirst: row[5],
    attack_start_time: row[6].present? ? Time.at(row[6]).strftime("%e %m %Y - %H:%M:%S") : 'Nothing',
    attack_end_time: row[7].present? ? Time.at(row[7]).strftime("%e %m %Y - %H:%M:%S") : 'Nothing',
    attack_type: row[8].present? ? row[8] : 'Nothing'
  }
end

# SQL Query to remove a hero by his id
def remove_hero(id)
  @db.execute "DELETE FROM Heros WHERE id = #{id}"
end

# SQL Query to walk interaction
def hero_walk(id)
  hero = get_hero(id)
  return nil if hero.nil?

  diffs = {
    level: (hero[:level] + rand(0..0.01)).round(3),
    food: (hero[:food] - rand).round(1),
    thirst: (hero[:thirst] - rand).round(1),
  }

  @db.execute <<-SQL
    UPDATE heros SET 
    level = #{ diffs[:level] },
    food = #{ diffs[:food] },
    thirst = #{ diffs[:thirst] }
    WHERE id = #{id}
  SQL

  {
    id: hero[:id],
    name: hero[:name],
    level: {
      old: hero[:level],
      new: diffs[:level]
    },
    food: {
      old: hero[:food],
      new: diffs[:food]
    },
    thirst: {
      old: hero[:thirst],
      new: diffs[:thirst]
    }
  }
end

# SQL Query to search dragon interaction
def hero_search_dragon(id)
  hero = get_hero(id)
  return nil if hero.nil?

  return 'KO' unless hero[:attack_start_time].present? &&
      hero[:attack_end_time].present? && hero[:attack_type].present?

  @db.execute <<-SQL
    UPDATE heros SET 
    attack_start_time = #{(Time.now - 1.day).to_i},
    attack_end_time = #{(Time.now + 1.day).to_i},
    attack_type = "Dragon"
    WHERE id = #{id}
  SQL

  {
    name: hero[:name],
    start_time_attack: (Time.now - 1.day).strftime("%e %m %Y - %H:%M:%S"),
    end_time_attack: (Time.now + 1.day).strftime("%e %m %Y - %H:%M:%S")
  }
end

# SQL Query to fight dragon interaction
def hero_fight_dragon(id)
  hero = get_hero(id)
  return nil if hero.nil?

  timers_query = @db.prepare("SELECT name, attack_start_time, attack_end_time FROM Heros WHERE id = #{id} LIMIT(1)")
  timers_query_ret = timers_query.execute
  timers = timers_query_ret.first
  return 'KO' if (timers[2]..timers[3]).include? Time.now

  diffs = {
    level: (hero[:level] + rand(3..15)).round(3),
    life: (hero[:life] - rand(5.0..20.0)).round(1),
    food: (hero[:food] - rand(5.0..20.0)).round(1),
    thirst: (hero[:thirst] - rand(5.0..20.0)).round(1),
  }

  @db.execute <<-SQL
    UPDATE heros SET 
    level = #{diffs[:level]},
    life = #{diffs[:life]},
    food = #{diffs[:food]},
    thirst = #{diffs[:thirst]},
    attack_start_time = NULL,
    attack_end_time = NULL,
    attack_type = NULL
    
    WHERE id = #{id}
  SQL

  {
      id: hero[:id],
      name: hero[:name],
      level: {
          old: hero[:level],
          new: diffs[:level]
      },
      life: {
          old: hero[:life],
          new: diffs[:life]
      },
      food: {
          old: hero[:food],
          new: diffs[:food]
      },
      thirst: {
          old: hero[:thirst],
          new: diffs[:thirst]
      }
  }
end
