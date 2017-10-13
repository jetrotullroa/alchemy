defmodule PhzxTest do
  use ExUnit.Case
  doctest Phzx

  test "escape_velocity(:earth)" do
    assert Phxz.Rocketry.escape_velocity(:earth) == 11.2
  end

end
