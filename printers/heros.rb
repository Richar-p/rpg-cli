# Create a hero and print his ID and his name
def create_and_print_hero(name)
  create_hero(name)
  puts "Welcome home #{name}, you're ID is #{get_heros.first[0]}"
end

# Print all stats and info about all heros
def print_heros
  rows = get_heros

  rows.each do |row|
    h = {
        id: row[0],
        name: row[1],
        level: row[2],
        life: row[3],
        food: row[4],
        thirst: row[5]
    }

    puts h.ai
  end
end

# Print all stats and info about one hero selected by his ID
def print_hero(id)
  return puts 'You need to provide an id' if id.nil?

  row = get_hero(id)
  h = {
      id: row[0],
      name: row[1],
      level: row[2],
      life: row[3],
      food: row[4],
      thirst: row[5]
  }

  puts h.ai
end

# Remove an hero, and say it goodbye
def remove_and_print_hero(id)
  name = get_hero(id)[1]
  remove_hero(id)

  puts "#{name} are dead in the war."
end