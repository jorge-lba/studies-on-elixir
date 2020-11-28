defmodule ExMon.Game.Status do
  @moduledoc """
  Este modulo é responsavel por trazer informações da partida.
  """

  @doc """
    # Visualizar Player
    ## Exemplo
    **Chamando a função `print_round_massege/0`**
    ```elixir
    ExMon.Game.Status.print_round_message()
    ```
    **Resultado**
    ```sh
    ==== The game is started! ====
    %{
      computer: %ExMon.Player{
        life: 100,
        moves: %{
          move_avg: :kick,
          move_heal: :heal,
          move_rnd: :punch
        },
        name: "Robotinik"
      },
      player: %ExMon.Player{
        life: 100,
        moves: %{
          move_avg: :soco,
          move_heal: :cura,
          move_rnd: :chute
        },
        name: "Rahmai"
      },
      status: :start,
      turn: :player
    }
    ------------------------------
    :ok
    ```
  """
  def print_round_message(%{status: :started} = info) do
    IO.puts("\n==== The game is started! ====\n")
    IO.inspect(info)
    IO.puts("------------------------------")
  end

  def print_round_message(%{status: :continue, turn: player} = info) do
    IO.puts("\n==== It's #{player} turn. ====\n")
    IO.inspect(info)
    IO.puts("------------------------------")
  end

  def print_round_message(%{status: :game_over} = info) do
    IO.puts("\n==== The game is over. ====\n")
    IO.inspect(info)
    IO.puts("------------------------------")
  end

  @doc """
    # Mensagem de Movimento Invalido
    Está função printa no terminal uma mensagem de movimento invalido.

    ## Parâmetros
      - `move` - Atom com o nome do movimento.

    ## Exemplo

    **Chamando a função `print_wrong_move_message/1`**
    ```elixir
    ExMon.Game.Status.print_wrong_move_message(:invalid)
    ```
    **Resultado**
    ```sh
    ==== Invalid move: invalid. ====

    :ok
    ```
  """
  def print_wrong_move_message(move) do
    IO.puts("\n==== Invalid move: #{move}. ====\n")
  end

  def print_move_message(:computer, :attack, damage) do
    IO.puts("\n==== The Player attacked the Computer dealing #{damage} damage. ====\n")
  end

  def print_move_message(:player, :attack, damage) do
    IO.puts("\n==== The Computer attacked the Player dealing #{damage} damage. ====\n")
  end

  def print_move_message(player, :heal, life) do
    IO.puts("\n==== The #{player} healled itself to #{life} life points. ====\n")
  end
end
