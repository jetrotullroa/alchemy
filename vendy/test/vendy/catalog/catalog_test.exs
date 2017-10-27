defmodule Vendy.CatalogTest do
  use Vendy.DataCase
  alias Vendy.{Catalog, Repo}
  alias Vendy.Catalog.Product

  setup do
    Repo.insert %Product{
      name: "Tomato",
      price: 55,
      sku: "A123",
      is_seasonal: false,
      category: "vegetables"
    }
    Repo.insert %Product{
      name: "Apple",
      price: 100,
      sku: "B232",
      is_seasonal: true,
      category: "fruits"
    }
    :ok
  end

  test "list_products/0 returns all products" do
    [p1 = %Product{}, p2 = %Product{}] = Catalog.list_products
    assert p1.name === "Tomato"
    assert (p1.price |> Decimal.to_string) === "55"
    assert p2.name === "Apple"
    assert (p2.price |> Decimal.to_string) === "100"
  end

  test "list_seasonal_products/0 return only seasonal products" do
    [product = %Product{}] = Catalog.list_seasonal_products
    refute product.name === "Tomato"
  end

  test "get_category_product/1 return products based on category" do
    [product = %Product{}] = Catalog.get_category_product("fruits")

    refute product.name === "Tomato"
  end

end
