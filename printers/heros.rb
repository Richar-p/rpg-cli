module Printers
  class Heros
    def get_heros
      Database::Heros.get_heros()
    end

    def get_hero(id)
      Database::Heros.get_hero(id)
    end
  end
end
