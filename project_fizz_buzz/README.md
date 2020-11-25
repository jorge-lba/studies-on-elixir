# ProjectFizzBuzz

Neste projeto vamos criar uma "sistema" que vai verificar uma lista de numero em um arquivo `.txt`, se o numero for múltiplo de 3 ele será substituído por Fizz, se for múltiplo de 5 ele será substituído por Buzz e se for múltiplo de 3 e 5 será substituído por FizzBuzz. 

## Iniciando o Projeto

Para gerar a primeira estrutura vamos utilizar o commando `mix` do Elixir no terminal.

*Selecione a pasta onde você vai iniciar o projeto e digite:*
```sh
mix new project_fizz_buzz
```
Após o comando vai ser gerada a estrutura base do projeto com as pastas `lib` e `test`.

Na pasta **lib** vamos colocar todo o nosso código fonte.
Na pasta **test** vamos adicionar nossos teste.

Alem dos arquivos de exemplos que foram adicionados nas pastas `lib` e `test` o `mix new` criou os arquivos `.formatter.exs`, `.gitignore`, `README.md` e `mix.exs`.

O arquivo `README.md` é este que você está lendo agora, nele documentamos nosso projeto.
O arquivo `.gitignore` é responsável por barrar pastas e arquivos que não queremos armazenar em nos commits e repositórios.

O arquivo `.formatter.exs` é responsável por armazenar as configurações da formatação do nosso projeto.

E o arquivo `mix.exs` contem as informações do nosso projeto como nome, versão, libs utilizadas ...

## Compilando
Para rodar um projeto precisamos gerar o `build` dele, para isso temos que abrir o terminal na pasta do projeto e digitar o comando `mix compile`.
Após o comando será criada uma pasta `_build`, onde podemos ver os arquivos gerados.

Vamos rodar os testes para ver se tudo está OK, dentro da pasta do projeto execute no terminal o comando `mix test`, os testes iram rodar e sinalizar que foram bem sucedidos.

***obs:** Vamos deixar combinado que toda vez que eu falar para executar um comando no terminal você deve estar na pasta raiz do projeto.

## Iniciando nosso projeto
Agora vamos dar inicio ao projeto FizzBuzz, para começar vamos criar o arquivo com os números na parta raiz do projeto, o nome do arquivo vai ser `numbers.txt` dentro dele vamos colocar essa lista de números `1,2,3,4,5,10,15,20,21,23,28,30,33`.

### Lendo o arquivo TXT
Vamos alterar o arquivo gerado com o `mix new` na pasta lib para ler o nosso `numbers.txt`.
Para isso vamos adicionar o seguinte código:
```elixir
defmodule ProjectFizzBuzz do
  def build(file_name) do
    file_name
    |> File.read()
    |> handle_file_read()
  end

  def handle_file_read({:ok, result}), do: result
  def handle_file_read({:error, reason}), do: reason
end
```
Para ver se nosso modulo está funcionando vamos no terminal e digitar o comando `iex -S mix`, com esse comando entraremos no modo interativo iex com o nosso projeto já executando.

Após isso vamos acessar nosso modulo e a função dentro dele com o seguinte comando `ProjectFizzBuzz.build("numbers.txt")`, se tudo ocorreu bem o resultado deve ter sigo algo assim:
```elixir
iex(1)> ProjectFizzBuzz.build("numbers.txt")
"1,2,3,4,5,10,15,20,21,23,28,30,33"
```
Vamos ver o resultado caso o arquivo passado não exista.
```elixir
iex(2)> ProjectFizzBuzz.build("number.txt") 
:enoent
```

### Resultado final
Agora vamos formatar os dados recebidos, quando a listar retorna ela vem como string, vamos quebrar ela em uma lista e transformar no tipo `number`.

Vamos alterar a função `handle_file_read` que lê o `:ok` para a seguinte forma:
```elixir
defp handle_file_read({:ok, result}) do
  result = result
  |> String.split(",")
  |> Enum.map( &convert_and_evaluate_numbers/1 )

  {:ok, result}
end
```
Vamos entender o que mudou:

1.  Estamos utilizando `defp` em vez do `def`, isso garante que nossa função seja privada, assim quem for utilizar nosso modulo não terá acesso a esta função.

2.  Agora estamos atribuindo o resultado da nossa `pipe` na variável `result`
3.  A Primeira função está pegando nossa string e quebrando onde tem uma virgula, isso nos retorna uma lista com todos os numero ainda como strings.
4. A segunda função está percorrendo cada item da lista que foi passada e executando a função `convert_and_evaluate_numbers` utilizando cada um dos valores da lista, a função `Enum.map` nos retorna uma nova lista com o resultado da função passada.
5. Por ultimo retornamos a tupla informando que a função foi executada com sucesso e o resultado `{:ok, result}`.

Vamos adicionar e ver o que nossa função `convert_and_evaluate_numbers` faz.
```elixir
defp convert_and_evaluate_numbers(element) do
  element
  |> String.to_integer()
  |> evaluate_number()
end
```
Essa função recebe um valor do tipo `string` para ser tratada.

1. Adicionamos nossa variável element para executar o pipe.
2. Vamos utilizar a função `String.to_integer` para converter o elemento em um numero.
3. Chamamos a função `evaluate_number` para fazer a mudança do valor segundo nossas condições.

Iremos adicionar agora as nossas funções `evaluate_number`.

1. Essa função vai verificar se o numero passado é múltiplo de 3 e de 5, caso seja ela retorna nosso atom `:fizbuzz`, se não passara para apróxima função.
    ```elixir
    defp evaluate_number(number) when rem(number,3) == 0 and rem(number, 5) == 0, do: :fizzbuzz
    ```
2. Agora vamos verificar se o numero é apensa múltiplo de 3, caso seja retornamos `:fizz` caso contrario vamos para a próxima função.
    ```elixir
    defp evaluate_number(number) when rem(number,3) == 0, do: :fizz
    ```
3. Nessa função vamos verificar se o numero é múltiplo de 5, caso seja retornarmos `:buzz` e se não iremos para a ultima função.
    ```elixir
    defp evaluate_number(number) when rem(number,5) == 0, do: :buzz
    ```
4. Neste caso nenhuma das condições anteriores eram verdadeiras, então vamos retornar o mesmo numero que foi recebido.
```elixir
defp evaluate_number(number), do: number
```
O seu código final deve ser semelhante a este:

```elixir
defmodule ProjectFizzBuzz do
  def build(file_name) do
    file_name
    |> File.read()
    |> handle_file_read()
  end
  defp handle_file_read({:ok, result}) do
    result = result
    |> String.split(",")
    |> Enum.map( &convert_and_evaluate_numbers/1 )

    {:ok, result}
  end
  defp handle_file_read({:error, reason}), do: {:error, "Erro: reading the file: #{reason}"}

  defp convert_and_evaluate_numbers(element) do
    element
    |> String.to_integer()
    |> evaluate_number()
  end

  defp evaluate_number(number) when rem(number,3) == 0 and rem(number, 5) == 0, do: :fizzbuzz
  defp evaluate_number(number) when rem(number,3) == 0, do: :fizz
  defp evaluate_number(number) when rem(number,5) == 0, do: :buzz
  defp evaluate_number(number), do: number
end
```
Se tudo estiver certo quando executarmos o comando `ProjectFizzBuzz.build("numbers.txt")` no modo interativo `iex -S mix` teremos este resultado:
```elixir
{:ok,
 [1, 2, :fizz, 4, :buzz, :buzz, :fizzbuzz, :buzz, :fizz, 23, 28, :fizzbuzz,
  :fizz]}
```

***obs:** Esse resultado se refere aos números passados no arquivo `numbers.txt`, caso você tenha adicionado números diferente o resultado deve ser outro.

## Testes
Vamos adicionar dois testes, um para verificar o retorno quando passado um arquivo valido e outro quando for passado um arquivo invalido.

Vamos modificar o nosso arquivo `project_fizz_buzz.exs` adicionando o seguinte código:

```elixir
defmodule ProjectFizzBuzzTest do
  use ExUnit.Case

  describe "build/1" do
    test "when a valid file is provided, returns the converted list" do
      expected_response =
        {:ok, [1, 2, :fizz, 4, :buzz, :buzz, :fizzbuzz, :buzz, :fizz, 23, 28, :fizzbuzz, :fizz]}

      assert ProjectFizzBuzz.build("numbers.txt") == expected_response
    end

    test "when an invalid file is provided, returns an error" do
      expected_response = {:error, "Erro: reading the file: enoent"}

      assert ProjectFizzBuzz.build("invalid.txt") == expected_response
    end
  end
end
```

O `use ExUnit.Case` carrega as funcionalidades que vamos usar para criar nossos testes.

Iniciamos nosso testes informando o nome da nossa função e sea aridade no `describe`. (Esse formato é uma convenção da comunidade Elixir)

Depois iniciamos nosso primeiro teste, que vai verificar se o retorno da nossa função está fazendo o esperado.
Utilizamos a variável `expected_response` para colocar o resultado que estamo esperando.
Para fazer o teste devemos usar o `assert` em seguida a função que queremos verificar, o operador de igualdade e a nossa variável `expected_response`.

O segundo teste é semelhante o nosso primeiro, mas vamos verificar o resultado da nossa função quando recebemos um arquivo invalido como entrada da nossa função.

### Executando os Testes
Para executar os testes utilizamos o comando `mix test` no terminal, o resultado deve ser este:

```elixir
..

Finished in 0.01 seconds
2 tests, 0 failures
```

### Formatar o Código
O Elixir tem uma função que faz a formatação do nosso código para ficar nos padrões esperados, digite o comando `mix format` e pronto seu código foi formatado.