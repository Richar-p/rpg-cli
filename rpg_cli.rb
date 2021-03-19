#!/usr/bin/env ruby

# @!group DEPENDANCES
require 'sqlite3'
require 'awesome_print'
require 'active_support/core_ext'
# @!endgroup

# @!group DATABASE
@database_path = './database/database.sqlite'
@db = SQLite3::Database.new @database_path
require './database/init.rb'
require './database/heros.rb'
# @!endgroup

# @!group PRINTERS
require './printers/heros.rb'
require './printers/engine.rb'
# @!endgroup

# @!group ARGUMENTS
arg_to_methods = {
  # Engine part
  'install'       => lambda { print_init },
  'help'          => lambda { print_help },
  # Heros part
  'new_hero'      => lambda { create_and_print_hero(ARGV[1])                },
  'hero'          => lambda { print_hero(ARGV[1])                           },
  'heros'         => lambda { print_heros                                   },
  'remove_hero'   => lambda { remove_and_print_hero(ARGV[1])                },
  'walk'          => lambda { make_a_hero_walk_and_print(ARGV[1])           },
  'search_dragon' => lambda { make_a_hero_search_dragon_and_print(ARGV[1])  },
  'attack_dragon' => lambda { make_a_hero_fight_dragon_and_print(ARGV[1])   }
}

if arg_to_methods.keys.include? ARGV[0]
  arg_to_methods[ARGV[0]].call
else
  puts 'Hmmmm. I don\'t know what i can do'
end
# @!endgroup
