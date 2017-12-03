defmodule Alchemist.Coordinator do
  def loop(results \\ [], results_expeceted) do
    receive do
      {:ok, result} ->
        new_result = [result | results ]
        if results_expeceted == Enum.count(new_results) do
          send self, :exit
        end
        loop(new_result, results_expeceted)
      :exit ->
        IO.puts(results |> Enum.sort |> Enum.join(", "))
      _error ->
        loop(results, results_expeceted)  
    end
  end
end
