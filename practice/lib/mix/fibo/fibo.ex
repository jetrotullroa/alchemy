defmodule Practice.Fibo do
  def naive(1), do: 1

  def naive(2), do: 1

  def naive(n) do
    naive(n - 2) + naive(n - 1)
  end
end
