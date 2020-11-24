defmodule ProjectFizzBuzzTest do
  use ExUnit.Case
  doctest ProjectFizzBuzz

  test "greets the world" do
    assert ProjectFizzBuzz.hello() == :world
  end
end
