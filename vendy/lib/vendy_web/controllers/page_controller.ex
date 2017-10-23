defmodule VendyWeb.PageController do
  use VendyWeb, :controller
  alias Vendy.Catalog

  def index(conn, _params) do
    seasonal_products = Catalog.list_seasonal_products
    render conn, "index.html", seasonal_products: seasonal_products
  end
end
