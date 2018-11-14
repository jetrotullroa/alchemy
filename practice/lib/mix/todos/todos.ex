defmodule Practice.Todos do
  use GenServer

  @moduledoc """
    User should be able to create a todo list, add, remove and view the todo list.
  """

  @doc false
  def start(list) do
    {:ok, todos} = GenServer.start(__MODULE__, list)
    todos
  end

  @doc """
    Add a todo on a todo list.

    ## Paramenters
      - todos: PID from the Practice.Todos.start
      - todo: String. todo to be added to todo list.

    ## Example
      iex> Practice.Todos.add(Practice.Todos.start([]), "feed the cat")
      :ok
  """
  def add(todos, todo) do
    GenServer.cast(todos, {:add, todo})
  end

  @doc """
    Remove a todo on a todo list.

    ## Paramenters
      - todos: PID from the Practice.Todos.start
      - todo: String. todo to be removed from todo list.

    ## Example
      iex> Practice.Todos.remove(Practice.Todos.start(["throw the trash", "feed the cat"]), "feed the cat")
      :ok
  """
  def remove(todos, todo) do
    GenServer.cast(todos, {:remove, todo})
  end

  @doc """
    List of todos

    ## Paramenters
      - todos: PID from the Practice.Todos.start

    ## Example
      iex> Practice.Todos.all(Practice.Todos.start(["throw the trash", "feed the cat"]))
      ["throw the trash", "feed the cat"]
  """
  def all(todos) do
    GenServer.call(todos, :all)
  end

  # callbacks

  @doc false
  def init(todos) do
    {:ok, todos}
  end

  def handle_cast({:add, todo}, todos) do
    {:noreply, [todo | todos]}
  end

  def handle_cast({:remove, todo}, todos) do
    {:noreply, List.delete(todos, todo)}
  end

  def handle_call(:all, _from, todos) do
    {:reply, todos, todos}
  end
end
