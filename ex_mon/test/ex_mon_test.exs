defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "crate_player/4" do
    test "Returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
        name: "Player"
      }

      assert expected_response == ExMon.create_player("Player", :chute, :soco, :cura)
    end
  end

  describe "start_game/1" do
    test "When the game is started, returns a message" do
      player = Player.build("Player", :chute, :soco, :cura)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "The game is started!"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Player", :chute, :soco, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "When the move is valid, do the move and the computer makes a move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:chute)
        end)

      assert messages =~ "The Player attacked the Computer" or "The player healled"
      assert messages =~ "The Computer attacked the Player" or "The computer healled"
      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, returns an error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:wrong)
        end)

      assert messages =~ "Invalid move: wrong."
    end

    test "when the move is valid and turn is game_over, returns an game over message" do
      new_state = %{
        computer: %ExMon.Player{
          life: 0,
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch},
          name: "Robotinik"
        },
        player: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Player"
        },
        status: :started,
        turn: :player
      }

      ExMon.Game.update(new_state)

      messages =
        capture_io(fn ->
          ExMon.make_move(:wrong)
        end)

      assert messages =~ "The game is over."
    end
  end
end
