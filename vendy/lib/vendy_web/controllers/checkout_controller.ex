defmodule VendyWeb.CheckoutController do
  use VendyWeb, :controller

  def edit(conn, _) do
    render conn, "edit.html"
  end
end
