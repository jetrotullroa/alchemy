defmodule Practice.Calcs.SumsTest do
  use ExUnit.Case
  setup do
    array_of_numbers = [1, 2, 4, 5, 2, 1]
    {:ok, array_of_numbers: array_of_numbers}
  end

  test "Sum of array", %{array_of_numbers: array_of_numbers} do
    assert Practice.Calcs.Sums.sum(array_of_numbers) == 1 + 2 + 4 + 5 + 2 + 1
  end

  test "check string changes if has T with U" do
    assert Practice.Calcs.Sums.replace_t("GCAT") === "GCAU"
  end
end
