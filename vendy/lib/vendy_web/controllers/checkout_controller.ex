defmodule VendyWeb.CheckoutController do
  use VendyWeb, :controller
  alias Vendy.Sales

  def edit(conn, _) do
    order = conn.assigns.cart
    order_changeset = Sales.change_cart(order)
    render conn, "edit.html", order: order, order_changeset: order_changeset
  end

  def update(conn, %{"order" => order_params}) do
    order = conn.assigns.cart
    order_params = Sales.associate_user_from_session(conn, order_params)
    case Sales.confirm_order(order, order_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Your order has been confirmed.")
        |> redirect(to: "/")
      {:error, order_changeset} ->
        render conn, "edit.html", order: order, order_changeset: order_changeset
    end
  end
end
