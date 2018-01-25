defmodule DolisttoTest do
  use ExUnit.Case
  doctest Dolistto

  test "load data from csv fille correctly" do
    assert Dolistto.init == "1,Study Erlang,2018-01-01,todo"
  end
end
