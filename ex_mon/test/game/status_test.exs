defmodule ExMon.Game.StatusTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Game.Status

  describe "print_round_message/1" do
    test "When tho state is the same it has started, resturn start game message." do
      info = %{status: :started, info: "OK"}

      message =
        capture_io(fn ->
          assert Status.print_round_message(info) == :ok
        end)

      assert message =~ "The game is started!"
      assert message =~ "OK"
    end

    test "When tho state is the same it has continue, resturn continue game message." do
      info = %{status: :continue, turn: :player}

      message =
        capture_io(fn ->
          assert Status.print_round_message(info) == :ok
        end)

      assert message =~ "It's player turn."
      assert message =~ "player"
    end

    test "When tho state is the same it has game over, resturn game over message." do
      info = %{status: :game_over, turn: :finish}

      message =
        capture_io(fn ->
          assert Status.print_round_message(info) == :ok
        end)

      assert message =~ "The game is over."
      assert message =~ "finish"
    end
  end
end
