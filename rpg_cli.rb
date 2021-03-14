# @!group DEPENDANCES
require "sqlite3"
require "awesome_print"
# @!endgroup

# @!group DATABASE
@database_path = './db/database.sqlite'
require './database/init.rb'
require './database/heros.rb'
# @!endgroup

# @!group PRINTERS
require './printers/heros.rb'
# @!endgroup

Printers::Heros.new.get_heros
