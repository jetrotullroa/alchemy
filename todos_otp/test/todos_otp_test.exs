defmodule TodosOtpTest do
  use ExUnit.Case
  doctest TodosOtp

  test "greets the world" do
    assert TodosOtp.hello() == :world
  end
end
