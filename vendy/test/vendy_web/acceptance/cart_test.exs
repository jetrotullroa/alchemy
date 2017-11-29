defmodule VendyWeb.CartTest do
  use Vendy.DataCase
  use Hound.Helpers

  hound_session()

  setup do
    alias Vendy.Repo
    alias Vendy.Catalog.Product

    Repo.insert %Product{ name: "Carrot", pack_size: "1kg", price: 55, sku: "A123", is_seasonal: true}
    Repo.insert %Product{ name: "Apple", pack_size: "1kg", price: 75, sku: "B321", is_seasonal: true}
    :ok
  end

  test "presence of cart form for each prodcut" do
    navigate_to("/")

    products = find_all_elements(:css, ".product")

    assert Enum.count(products) != 0
    products
    |> Enum.each(fn(product) ->
      button = find_within_element(product, :tag, "button")
      assert visible_text(button) == "Add to Cart"
    end)
  end

  test "add to cart" do
    navigate_to("/")

    [ product | _rest ] = find_all_elements(:css, ".product-thumbnail")
    product_name = find_within_element(product, :name, "cart[product_name]")
  end
end
