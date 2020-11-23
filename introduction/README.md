# Introdução

## [Instalação](https://elixir-lang.org/install.html)

Os comando abaixo devem ser rodados no terminal.

**Ubuntu**
| Descrição | Comandos |
| :-------: | :------: |
|Adicionar repositório `Erlang Solutions`| `wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb`|
| Executar | `sudo apt-get update`|
| Instale a plataforma Erlang / OTP e todos os seus aplicativos | `sudo apt-get install esl-erlang` |
| Instalar `Elixir` | `sudo apt-get install elixir` |

Verifique se o `Elixir` e o `Erlang` foram instalados com o comando `elixir --version`
Após o comando deve aparecer algo semelhante as isso:
```
Erlang/OTP 23 [erts-11.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [hipe]

Elixir 1.11.2 (compiled with Erlang/OTP 23)
```

Inicie o modo interativo digitando o comando `iex`
Após o comando deve aparecer algo semelhante as isso:
```
Erlang/OTP 23 [erts-11.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [hipe]

Interactive Elixir (1.11.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> 
```

Com o `iex` executando digite `"Hello World"` e aperte enter para testar, o resultado deve ser semelhante a isso:
```
iex(1)> "Hello World"
"Hello World"
iex(2)> 
```

## Tipos Básicos

Os tipos básicos sem semelhantes ao do `Javascript`, porem alguns podem ser diferentes, irei lista-los abaixo:

| Tipo | Javascript | Elixir |
 :---: | :--------: | :----: |
| Nulo | null | nil |
| *Atom | | :name |

*Atons são constantes que tem o mesmo valor que seu nome

O Elixir não é uma linguagem de tipagem forte, porem contem funções nativas para verificar o tipo de uma variável.

Para acessar essas funções no modo interativo (`iex`), basta digitar `is_` e apertar a tecla `tab`

### Funções matematicas

O operador de divição `/` sempre retorna um numero do tipo float.
```
iex(21)> 5/2
2.5
iex(22)> 1/2
0.5
iex(23)> 1/1
1.0
```
Para retornar o numero inteiro de uma divisão ou o resto da mesma é necessário utilizar funções. Exemplos:

| Tipo | Função | Resultado |
| :---: | :---: | :---: |
| Divisãi inteira | `div(5/2)` | 2 |
| Resto da divisão | `rem(5,2)` | 1 |

### Interpolação de strings
A interpolação de strings do Elixir é semelhante ao do Javascript, abaixo podemos ver as diferenças.

Para o exemplo vamos considerar o valor da variável `name` como Ana
|--------------- |------------------------------- | 
|:--- | :--- |
| **Javascript** | \`Meu nome é ${name}\` |
| **Elixir** | "Meu nome é #{name}" |
| **Resultado** | Meu nome é Ana |

Para esse tipo de interpolação no Javascript utilizamos as crazes para envolver a `string` e o `${}` para adicionar a variável dentro da frase. 

Já no Elixir podemos utilizar as aspas duplas `"` para envolver a `string` e o `#{}` para adicionar a variável dentro da frase.

### Concatenação de strings

A concatenação de strings do Elixir é semelhante ao do Javascript, abaixo podemos ver a diferença.

|--------------- |-------------------------------- | 
|:--- | :--- |
| **Javascript** | "Meu nome é " + "Ana" |
| **Elixir** | "Meu nome é " <> "Ana" |
| **Resultado** | Meu nome é Ana |

Note que em Javascript utilizamos o operador `+` para fazer a junção das duas strings, já no Elixir o operador é `<>`.

*obs: Caso seja adicionado o `+` em vez do `<>` no Elixir sera retornado um erro.

### Operadores lógicos
Os operadores `||` e `&&` também estão presentes no Elixir, mas tem alem da forma tradicional de ser chamada, ele tem uma outra forma.

| Comum | Secundaria | Resultado |
| :--: | :--: | :--: |
| `true || false` | `true or false` | `true` |
| `true && false` | `true and false` | `false` |

Essa segunda forma de usar o operador tona o código mais legível.

## Tuplas
Tuplas são semelhantes aos arrays em Javascript, que podem guardar diversos valores.

Diferente dos arrays do Javascript que usam colchetes `[]` as tuplas do Elixir utilizam chaves `{}`. Exemplo:

|--------------- |------------------------- |
| :-: | :-: |
| **Javascript** | `['banana', 200]` |
| **Elixir** | `{"banana", 200}` |

Geralmente as tuplas do Elixir são utilizadas para guardar valores que contem relações entre si. 