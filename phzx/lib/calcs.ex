defmodule Calcs do

  def square_root(val) do
    :math.sqrt(val)
  end

  def squared(val) do
    val * val
  end

  def cubed(val) do
    val * val * val
  end

  def cube_root(val) do
    square_root(val) / val
  end

  def pie, do: :math.pi

  def pie_squared, do: pie |> squared

end
