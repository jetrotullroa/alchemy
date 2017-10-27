defmodule VendyWeb.Acceptance do
  use Vendy.DataCase
  use Hound.Helpers

  hound_session()

  setup do
    alias Vendy.Repo
    alias Vendy.Catalog.Product

    Repo.insert %Product{
      name: "Tomato",
      price: 50,
      sku: "AB123",
      is_seasonal: true,
      category: "vegetables"
    }

    Repo.insert %Product{
      name: "Apple",
      price: 100,
      sku: "BD232",
      is_seasonal: false,
      category: "fruits"
    }

    :ok
  end

  test "presence of featured products" do
    navigate_to("/")
    page_title = find_element(:css, ".page-title") |> visible_text
    assert page_title === "Seasonal Products"

    product = find_element(:css, ".product")
    product_name = find_within_element(product, :css, ".product-name") |> visible_text
    product_price = find_within_element(product, :css, ".product-price") |> visible_text
    assert product_name === "Tomato"
    assert product_price === "50"
    refute product_name === "Apple"
  end
end
