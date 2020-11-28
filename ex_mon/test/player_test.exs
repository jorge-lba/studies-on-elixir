defmodule ExMon.PlayerTest do
  use ExUnit.Case

  alias ExMon.Player

  describe "build/4" do
    test "Create a new player." do
      name = "Player"
      move_avg = :soco
      move_rnd = :chute
      move_heal = :cura

      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Player"
      }

      assert expected_response == Player.build(name, move_avg, move_rnd, move_heal)
    end
  end
end
