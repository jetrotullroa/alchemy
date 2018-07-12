defmodule Todo.ListTest do
  use ExUnit.Case
  alias Todo.{Item, List}

  setup do
    {:ok, list} = List.start_link("Home")
    {:ok, list: list}
  end

  @item = "Create an otp app."

  test ".items return all todos", %{list: list} do
    assert List.items(list) === []
  end

  test ".add adds an item to the list", %{list: list} do
    item = Item.new(@item)
    List.add(list, item)

    assert List.items(list) == [item]
  end

  test ".update adds an item to the list"m %{list: list} do
    item = Item.new(@item)
    List.add(list, item)
    List.update(@)

    refute 
  end

end
