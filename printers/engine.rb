# Init database for start the game at the first time.
# And print help if no error occured.
def print_init
  print_help if init_database
end

# Print a tutorial for play
def print_help
  puts "Welcome to RPG-CLI.\n
- Create a new hero using the command \"rpg-cli new_hero [NAME]\"
- See your hero's stats/info using the command \"rpg-cli hero [ID]\"
- See all your heros and their stats/info using the command \"rpg-cli heros\"
- Delete an hero using the command \"rpg-cli delete [ID]\""
end