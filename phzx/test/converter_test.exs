defmodule ConverterTest do
  use ExUnit.Case
  doctest Converter

  setup do
    
  end

  test "rounded_to_the_nearest_tenth/1" do
    rounded = Converter.rounded_to_the_nearest_tenth(23.2)
    assert rounded == is_float
  end

end
