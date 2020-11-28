defmodule ExMon.Player do
  @moduledoc """
  Fornece uma função `build/4` para criar um player no jogo.
  """

  @required_keys [:life, :moves, :name]
  @max_life 100

  @enforce_keys @required_keys

  defstruct @required_keys

  @doc """
  ## Parâmetros
    Os parâmetros abaixo seram utilizados para criar o nosso player.

    - **name:** String para nomear o player.
    - **move_avg:** Atom para nomear o ataque moderado que dá entre 18-25 de dano.
    - **move_rnd:** Atom para nomear o ataque variado que da entre 10-35 de dano.
    - **move_heal:** Atom para nomear o poder de cura, curando entre 18-25 de vida.

  ## Exemplos
    Aqui podemos ver como a função deve ser chamada:
    ```elixir
    iex> ExMon.Player.build("Rahmai", :soco, :chute, :cura )
    ```
    E o resultado gerado:
    ```elixir
    %ExMon.Player{
      life: 100,
      move_avg: :soco,
      move_heal: :cura,
      move_rnd: :chute,
      name: "Rahmai"
    }
  """
  def build(name, move_avg, move_rnd, move_heal) do
    %ExMon.Player{
      life: @max_life,
      moves: %{
        move_avg: move_avg,
        move_heal: move_heal,
        move_rnd: move_rnd
      },
      name: name
    }
  end
end
