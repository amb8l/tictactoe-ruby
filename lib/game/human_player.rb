module Game
  class HumanPlayer
    attr_reader :type, :token

    def initialize(token)
      @type = :user
      @token = token
    end

    def compute_move(game)
    end
  end
end
