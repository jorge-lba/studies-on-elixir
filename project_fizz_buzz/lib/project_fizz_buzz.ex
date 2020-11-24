defmodule ProjectFizzBuzz do
  def build(file_name) do
    file_name
    |> File.read()
    |> handle_file_read()
  end

  def handle_file_read({:ok, result}), do: result |> convertToNumbers()
  def handle_file_read({:error, reason}), do: "Erro: reading the file: #{reason}"
  def convertToNumbers(string) do
    string
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end
