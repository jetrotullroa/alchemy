defmodule VendyWeb.CategoryController do
  use VendyWeb, :controller
  alias Vendy.Catalog

  def show(conn, %{"category" => name}) do
    categorized_products = Catalog.get_category_product(name)

    conn
    |> assign(:categorized_products, categorized_products)
    |> assign(:category_name, name)
    |> render("show.html")
  end

end
