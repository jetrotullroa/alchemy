defmodule Practice.LeapYears do
  def year_days(year) do
    #TODO ...

   cond do
     rem(year, 4) == 0 && century_leap_year(year) -> "#{year} has 366 days"
     true -> "#{year} has 365 days"
   end
  end

  def century_leap_year(year) do
    case is_century_year?(year) do
      true ->
        cond do
          rem(year, 400) == 0 -> true
          true -> false
        end
      false -> true
    end
  end

  def is_century_year?(year) do
    year_digit_count = String.length("#{year}") >= 3
    year_divisible_by_100 = rem(year, 100) == 0
    year_digit_count && year_divisible_by_100
  end
end
