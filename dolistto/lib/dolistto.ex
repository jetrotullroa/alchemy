defmodule Dolistto do
  @moduledoc """
  Documentation for Dolistto.
  """

  defstruct last_id: 0, todos: %{}

  @path_env %{dev: ["lib", "todos.csv"], test: ["test", "todos_test.csv"]}
  @path Path.join(@path_env[Mix.env])

  def init do
    @path
    |> read_file!
    |> format_to_work
  end

  defp read_file!(path) do
    path
    |> File.stream!
    |> Stream.map(&String.replace(&1, "\n", ""))
  end

  defp format_to_work(input) do
    format_todos = fn(el, acc) ->
      [id, task, date, status] = String.split(el, ",")
      id = String.to_integer(id)
      Map.put(acc, id, %Todo{id: id, task: task, date: date, status: status})
    end
    todos   = Enum.reduce(input, %{}, format_todos)
    last_id = Map.keys(todos) |> Enum.max
    %Dolistto{last_id: last_id, todos: todos}
  end

end
