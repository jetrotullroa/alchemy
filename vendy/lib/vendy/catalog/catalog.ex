defmodule Vendy.Catalog do
  alias Vendy.Catalog.Product
  def list_products do
    [
      %Product{name: "Tomato", price: "23", is_seasonal: false},
      %Product{name: "Apple", price: "9", is_seasonal: true}
    ]
  end

  def list_seasonal_products do
    list_products
    |> Enum.filter( fn(product) -> product.is_seasonal === true end )
  end
end
