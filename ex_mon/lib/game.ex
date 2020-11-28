defmodule ExMon.Game do
  @moduledoc """
  Este é responsavel por gerenciar o estado de uma partida, nele temos três funções.
    - `start/2` - Inicia uma partida
    - `info/0` - Retorna o estado da partida
    - `player/0` - Retorna o estado do jogador
  """
  alias ExMon.Player
  use Agent

  @doc """
  # Iniciar Partida
  ## Parâmetros
    Os parâmetros abaixo seram usados para iniciar uma partida.

    - **computer** e **player** - Ambos compostos por tuplas gerada pela função ExMon.Player.build/4
  ## Exemplo
  Criando variaveis `computer` e `player`
  ```elixir
  computer =
    ExMon.Player.build("Robotinik", :kick, :punch, :heal)
  ```
  ```elixir
  player =
    ExMon.Player.build("Rahmai", :soco, :chute, :cura)
  ```
  **Chamando a função `start/2`**
  ```elixir
  ExMon.Game.start(computer, player)
  ```
  **Resultado**
  ```elixir
  {:ok, #PID<#.###.#>}
  ```

  """
  def start(computer, player) do
    initial_value = %{computer: computer, player: player, turn: :player, status: :started}
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  @doc """
  # Estado da Partida
  ## Exemplo
  **Chamando a função `info/0`**
  ```elixir
  ExMon.Game.info()
  ```
  **Resultado**
  ```elixir
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
  ```
  """
  def info do
    Agent.get(__MODULE__, & &1)
  end

  def update(state) do
    Agent.update(__MODULE__, fn _ -> update_game_status(state) end)
  end

  @doc """
  # Visualizar Player
  ## Exemplo
  **Chamando a função `player/0`**
  ```elixir
  ExMon.Game.player()
  ```
  **Resultado**
  ```elixir
  %ExMon.Player{
      life: 100,
      moves: %{
        move_avg: :soco,
        move_heal: :cura,
        move_rnd: :chute
      },
      name: "Rahmai"
  }
  ```
  """
  def player, do: Map.get(info(), :player)
  def computer, do: Map.get(info(), :computer)
  def turn, do: Map.get(info(), :turn)

  def fetch_player(player), do: Map.get(info(), player)

  defp update_game_status(
         %{player: %Player{life: player_life}, computer: %Player{life: computer_life}} = state
       )
       when player_life == 0 or computer_life == 0,
       do: Map.put(state, :status, :game_over)

  defp update_game_status(state) do
    state
    |> Map.put(:status, :continue)
    |> update_turn()
  end

  defp update_turn(%{turn: :player} = state), do: Map.put(state, :turn, :computer)
  defp update_turn(%{turn: :computer} = state), do: Map.put(state, :turn, :player)
end
