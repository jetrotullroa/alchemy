defmodule Practice.LeapYearsTest do
  use ExUnit.Case
  import Practice.LeapYears, only: [year_days: 1]

  test "basic cases" do
    assert year_days(0) == "0 has 366 days"
    assert year_days(-64) == "-64 has 366 days"
    assert year_days(2016) == "2016 has 366 days"
    assert year_days(1974) == "1974 has 365 days"
    assert year_days(-10) == "-10 has 365 days"
    assert year_days(666) == "666 has 365 days"
    assert year_days(1857) == "1857 has 365 days"
  end
end
