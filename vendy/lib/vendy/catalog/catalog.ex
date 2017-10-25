defmodule Vendy.Catalog do
  alias Vendy.Catalog.Product

  def list_products do
    [
      %Product{name: "Tomato", price: "23", is_seasonal: false, category: "vegetables"},
      %Product{name: "Apple", price: "9", is_seasonal: true, category: "fruits"}
    ]
  end

  def list_seasonal_products do
    list_products
    |> Enum.filter( fn(product) -> product.is_seasonal === true end )
  end

  def get_category_product(category) do
    list_products
    |> Enum.filter( fn(product) -> product.category === category end)
  end
end
