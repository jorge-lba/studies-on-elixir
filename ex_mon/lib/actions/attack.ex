defmodule ExMon.Game.Actions.Attack do
  @moduledoc """
  Modulo responsavdel por ações de ataque.
  """

  alias ExMon.Game
  alias ExMon.Game.Status

  @move_avg_power 18..25
  @move_rnd_power 10..35

  @doc """
  # Atacar oponente
  ## Parâmetros
    - `opponent` - Atom informando qual oponente está sendo atacado.
    - `move` - Atom informando qual movimento de ataque foi dado.
  ## Exemplo
  **Chamando a função `attack_opponent/2`**
  ```elixir
  ExMon.Game.Actions.Attack.attack_opponent(:player, :move_rnd)
  ```
  **Resultado**
  ```elixir
  %ExMon.Player{
    life: 69,
    moves: %{
      move_avg: :soco,
      move_heal: :cura,
      move_rnd: :chute
    },
    name: "Rahmai"
  }
  ```
  *obs: Como o valor do ataque é random o life pode variar.
  """
  def attack_opponent(opponent, move) do
    damage = calculate_power(move)

    opponent
    |> Game.fetch_player()
    |> Map.get(:life)
    |> calculate_total_life(damage)
    |> update_opponent_life(opponent, damage)
  end

  defp calculate_power(:move_avg), do: Enum.random(@move_avg_power)
  defp calculate_power(:move_rnd), do: Enum.random(@move_rnd_power)

  defp calculate_total_life(life, damage) when life - damage < 0, do: 0
  defp calculate_total_life(life, damage), do: life - damage

  defp update_opponent_life(life, opponent, damage) do
    opponent
    |> Game.fetch_player()
    |> Map.put(:life, life)
    |> update_game(opponent, damage)
  end

  defp update_game(player, opponent, damage) do
    Game.info()
    |> Map.put(opponent, player)
    |> Game.update()

    Status.print_move_message(opponent, :attack, damage)
  end
end
