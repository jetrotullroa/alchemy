defmodule PhzxTest do
  use ExUnit.Case
  doctest Phzx

  test "escape_velocity(:earth)" do
      assert Phxz.Rocketry.escape_velocity(:earth) == 11.2
  end

  test "escape_velocity(:mars)" do
      assert Phxz.Rocketry.escape_velocity(:mars) == 5.1
  end

  test "escape_velocity(:moon)" do
      assert Phxz.Rocketry.escape_velocity(:moon) == 2.4
  end

  test "orbital_acceleration/1" do
    assert Phxz.Rocketry.orbital_acceleration(100) == 9.6
  end

end
