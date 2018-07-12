defmodule Practice.Calcs.Sums do
  def sum(list) do
    do_sum(list, 0)
  end

  defp do_sum([], acc) do
    acc
  end

  defp do_sum([head | tail], acc) do
    do_sum(tail, acc + head)
  end

  def sum_func(list, func) do
    do_sum_func(list, func, 0)
  end

  defp do_sum_func([], _func, acc) do
    acc
  end

  defp do_sum_func([h | t], func, acc) do
    result = func.(h + acc)
    do_sum_func(t, func, result)
  end

  def sigil_x(content, _opts) do
    content
    |> String.replace("T", "U")
  end

  def replace_t(string) do
    ~x/#{string}/
  end
end
