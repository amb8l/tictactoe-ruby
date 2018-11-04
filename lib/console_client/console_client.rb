require 'game/game'
require 'game/game_engine'
require 'game/player'

module ConsoleClient
  class ConsoleClient
    def initialize(io, text_provider, ui)
      @io = io
      @tp = text_provider
      @ui = ui
    end

    def start
      begin
        continue = display_main_menu
      end while !@io.exit?
      @io.display(@tp::QUIT)
      @io.exit
    end

    private

    def display_main_menu
      @io.clear_screen
      @io.display(@tp::TITLE)
      @io.display(@tp::HELP)
      @io.display(@tp::MAIN_MENU)
      case @io.get_input(['1', '2'], @tp::INVALID_SELECTION)
      when '1'
        play_game
      else
        @io.exit = true
      end
    end

    def play_game
      player_one = configure_player(1, 'X', 'Player 1')
      player_two = configure_player(2, 'O', 'Player 2') unless @io.exit?
      if !@io.exit?
        engine = Game::GameEngine.new(@ui)
        engine.start(player_one, player_two)
      end
      display_return_to_main_menu unless @io.exit?
    end

    def configure_player(player, token, name)
      @io.clear_screen
      @io.display(@tp::PLAYER_TYPE)
      case @io.get_input(['1', '2', '3'], @tp::INVALID_SELECTION)
      when '1'
        Game::Player.create(:human, token, name)
      when '2'
        Game::Player.create(:easy, token, name)
      when '3'
        Game::Player.create(:hard, token, name)
      end
    end

    def display_return_to_main_menu
      @io.display(@tp::RETURN_TO_MAIN_MENU)
      input = @io.get_input(['y', 'n'], @tp::INVALID_SELECTION)
      @io.exit = true if input != 'y'
    end
  end
end
