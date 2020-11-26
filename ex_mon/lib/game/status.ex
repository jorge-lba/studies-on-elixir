defmodule ExMon.Game.Status do
  @moduledoc """
  Este modulo é responsavel por trazer informações da partida.
  """
  alias ExMon.Game

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
  def print_round_message do
    IO.puts("\n==== The game is started! ====\n")
    IO.inspect(Game.info())
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
end
