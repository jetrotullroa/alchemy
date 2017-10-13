defmodule Converter do

  def rounded_to_the_nearest_tenth(val) do
    Float.ceil(val, 1)
  end

  def convert_to_km(m) do
    m / 1000
  end

  def to_light_seconds({:miles, miles} = val, precision: precision) do
    (miles * 5.36819e-6) |> round_up
  end

  def to_light_seconds({:meters, meters} = val, precision: precision) do
    (meters * 3.335638620368e-9) |> round_up
  end

  def round_up(val) when is_float(val), do: trunc(val)

end
