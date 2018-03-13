defmodule VendyWeb.OrderView do
  use VendyWeb, :view
  use Timex

  def format_order_date(date) do
    {:ok, formatted_date} = date
    |> Timex.format("{D} {Mshort} {YYYY}")
    formatted_date
  end
end
