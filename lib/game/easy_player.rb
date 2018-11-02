module Game
  class EasyPlayer
    attr_reader :type, :token

    def initialize(token)
      @type = :computer
      @token = token
    end

    def compute_move(game, position = nil)
      game.available_positions.sample
    end
  end
end
