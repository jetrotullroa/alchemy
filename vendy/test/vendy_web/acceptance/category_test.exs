defmodule Vendy.CategoryTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session()

  #Products categorized by either fruits or vegetables
  #Show all vegetables on path category/vegetables
  #Show all fruits on path category/fruits
  #Each product should display its name

  test "Show all vegetables on path categories/vegetables" do
    navigate_to("/categories/vegetables")

    page_title = find_element(:css, ".page-title") |> visible_text
    assert page_title === "Vegetables"

    product = find_element(:css, ".product")
    product_name = find_within_element(product, :css, ".product-name") |> visible_text
    product_price = find_within_element(product, :css, ".product-price") |> visible_text

    assert product_name === "Tomato"
    assert product_price === "23"
    refute page_source() =~ "Apple"
  end

  test "Show all fruits on path categories/fruits" do
    navigate_to("/categories/fruits")

    page_title = find_element(:css, ".page-title") |> visible_text
    assert page_title === "Fruits"

    product = find_element(:css, ".product")
    product_name = find_within_element(product, :css, ".product-name") |> visible_text
    product_price = find_within_element(product, :css,".product-price") |> visible_text

    assert product_name === "Apple"
    assert product_price === "9"
    refute page_source() =~ "Tomato"
  end

end
