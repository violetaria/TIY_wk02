class ScoreBoard

  def initialize
    @wins = 0
    @draws = 0
    @losses = 0
  end

  def wins
    @wins
  end

  def add_win
    @wins+=1
  end

  def losses
    @losses
  end

  def add_loss
    @losses+=1
  end

  def draws
    @draws
  end

  def add_draw
    @draws+=1
  end

  def display_scoreboard
    puts "wins: #{@wins} <> losses: #{@losses} <> draws: #{@draws}"
  end
end
