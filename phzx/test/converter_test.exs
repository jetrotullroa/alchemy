defmodule ConverterTest do
  use ExUnit.Case
  doctest Converter

  test "convert to_light_seconds" do
    converted = Converter.to_light_seconds({:miles, 1000}, precision: 5)
    assert converted == 0.00537
  end

end
