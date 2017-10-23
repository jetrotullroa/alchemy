defmodule VendyWeb.Acceptance do
  use ExUnit.Case
  use Hound.Helpers

  hound_session()

  test "presence of featured products" do
    navigate_to("/")
    page_title = find_element(:css, ".page-title") |> visible_text
    assert page_title === "Seasonal Products"

    product = find_element(:css, ".product")
    product_name = find_within_element(product, :css, ".product-name") |> visible_text
    product_price = find_within_element(product, :css, ".product-price") |> visible_text
    assert product_name === "Apple"
    assert product_price === "9"
    refute product_name === "Tomato"
  end
end
