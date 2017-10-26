defmodule Vendy.CatalogTest do
  use ExUnit.Case
  alias Vendy.Catalog
  alias Vendy.Catalog.Product

  test "list_products/0 returns all products" do
    [p1 = %Product{}, p2 = %Product{}] = Catalog.list_products
    assert p1.name === "Tomato"
    assert p1.price === "23"
    assert p2.name === "Apple"
    assert p2.price === "9"
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
