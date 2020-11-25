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
