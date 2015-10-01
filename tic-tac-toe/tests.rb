require 'minitest/autorun'

require './player'

class PlayerTest < MiniTest::Test
  def test_can_make_player
    named_player = Player.new("Terri")
    assert named_player.name == "Terri"

    unnamed_player = Player.new
    assert unnamed_player.name == "Unimatrix Zero"
  end
end

