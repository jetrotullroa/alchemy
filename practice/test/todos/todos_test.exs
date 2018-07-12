defmodule Practice.TodosTest do
  use ExUnit.Case
  alias Practice.Todos
  doctest Todos

  @todo "take a power nap"
  @todos ["buy milk", "clean the house", "throw the trash"]
  @done "clean the house"

  setup do
    todos = Todos.start([])
    todos_complete = Todos.start(@todos)
    {:ok, todos: todos, todos_complete: todos_complete}
  end

  test "add a todo to todos", %{todos: todos, todos_complete: _todos_complete} do
    Todos.add(todos, @todo)
    assert Todos.all(todos) === [@todo]
  end

  test "remove a todo from todos", %{todos: _todos, todos_complete: todos_complete} do
    Todos.remove(todos_complete, @done)
    assert Todos.all(todos_complete) === List.delete(@todos, @done)
  end

  test "view all todos", %{todos: _todos, todos_complete: todos_complete} do
    assert Todos.all(todos_complete) === @todos
  end
end
