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