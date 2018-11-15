defmodule Practice.Fibo do
  def process_time(func, args, label \\ "Function") do
    t0 = Time.utc_now()
    f = func.(args)
    diff = Time.diff(Time.utc_now(), t0, :millisecond)
    IO.puts("#{label} : #{f} completed in #{diff}ms")
  end

  def compare(n \\ 45) do
    process_time(&naive/1, n, "Naive")
    process_time(&faster/1, n, "Faster")
  end

  def naive(1), do: 1

  def naive(2), do: 1

  def naive(n) do
    naive(n - 2) + naive(n - 1)
  end

  def faster(n), do: faster(n, 0, 1)
  def faster(1, _acc1, acc2), do: acc2

  def faster(n, acc1, acc2) do
    faster(n - 1, acc2, acc1 + acc2)
  end
end
