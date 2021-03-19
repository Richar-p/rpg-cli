# Create a hero and print his ID and his name
def create_and_print_hero(name)
  create_hero(name)
  puts "Welcome home #{name}, you're ID is #{get_heros.first[:id]}"
end

# Print all stats and info about all heros
def print_heros
  rows = get_heros

  return puts 'No hero found :(' if rows.empty?

  rows.each { |row| puts row.ai }
end

# Print all stats and info about one hero selected by his ID
def print_hero(id)
  return puts 'You need to provide an id' if id.nil?

  row = get_hero(id)

  return puts 'Hero not found :(' if row.nil?

  puts row.ai
end

# Remove an hero, and say it goodbye
def remove_and_print_hero(id)
  return puts 'You need to provide an id' if id.nil?

  name = get_hero(id)[:name]
  remove_hero(id)

  puts "#{name} are dead in the war."
end

# Go walk in the nature
def make_a_hero_walk_and_print(id)
  return puts 'You need to provide an id' if id.nil?

  interact = hero_walk(id)

  return puts 'Hero not found :(' if interact.nil?

  puts "#{interact[:name]} have take a good time outside."
  puts interact.ai
end

def make_a_hero_search_dragon_and_print(id)
  interact = hero_search_dragon(id)

  return 'Hero not found :(' if interact.nil?
  return 'Search already in progress...' if interact == 'KO'

  puts interact.ai
end

def make_a_hero_fight_dragon_and_print(id)
  interact = hero_fight_dragon(id)

  return 'Search already in progress...' if interact == 'KO'

  unless [interact[:life][:new], interact[:food][:new], interact[:thirst][:new]].select { |v|  v >= 0  }.present?
    puts "#{interact[:name]} BEAT THE DRAGON!"
  else
    remove_hero(id)
    puts "#{interact[:name]} fallen in war. Pray for him."
  end
end