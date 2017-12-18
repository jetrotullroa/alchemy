defmodule Vendy.Sales do
  alias Vendy.Repo
  alias Vendy.Sales.Order

  def get_cart(id) do
    Order
    |> Repo.get_by(id: id, status: "In Cart")
  end

  def create_cart do
    %Order{status: "In Cart"} |> Repo.insert!()
  end

end
