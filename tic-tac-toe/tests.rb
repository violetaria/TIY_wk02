require 'minitest/autorun'

require './player'
require './human'

class PlayerTest < MiniTest::Test
  def test_can_make_player
    named_player = Player.new("Terri")
    assert_equal(named_player.name, "Terri")

    unnamed_player = Player.new
    assert_equal(unnamed_player.name,"Unimatrix Zero")
  end
end

class HumanTest < MiniTest::Test
  def test_can_make_human_player
    named_human_player = Human.new("Terri")
    assert_equal(named_human_player.name,"Terri")

    Human.stub :new, "Yang" do
      unnamed_human_player = Human.new
      refute_equal(unnamed_human_player ,"Unimatrix Zero")

    end
  end
end
