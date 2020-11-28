defmodule ExMon.Game.Actions do
  @moduledoc """
  Este modulo é responsavel por controlar as Ações dos Players, utilizando as seguinte funções:
    - `fetch_move/1` - Essa função é reponsavel buscar o movimento no player.
    - `find_moves/2` - Essa Função verifica se o movimento é valido.
  """
  alias ExMon.Game
  alias ExMon.Game.Actions.{Attack, Heal}

  def attack(move) do
    case Game.turn() do
      :player -> Attack.attack_opponent(:computer, move)
      :computer -> Attack.attack_opponent(:player, move)
    end
  end

  def heal() do
    case Game.turn() do
      :player -> Heal.heal_life(:player)
      :computer -> Heal.heal_life(:computer)
    end
  end

  @doc """
  # Buscar Movimento
  ## Parâmetros
    - `move` - Atom com o nome do movimento que vai ser buscado.
  ## Exemplo
  **Chamando a função `fetch_move/1`
  ```elixir
  ExMon.Game.Actions.fetch_move(:chute)
  ```
  **Resultado**
  ```elixir
  {:ok, :move_rnd}
  ```
  """
  def fetch_move(move) do
    Game.player()
    |> Map.get(:moves)
    |> find_moves(move)
  end

  defp find_moves(moves, move) do
    Enum.find_value(moves, {:error, move}, fn {key, value} ->
      if value == move, do: {:ok, key}
    end)
  end
end
