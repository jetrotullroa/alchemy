defmodule CalcsTest do
  use ExUnit.Case
  doctest Calcs


  test "square_root/1" do
    assert Calcs.square_root(9) == 3.0
  end

  test "squared/1" do
    assert Calcs.squared(9) == 81
  end

  test "cubed" do
    assert Calcs.cubed(9) == 729
  end

  
end
