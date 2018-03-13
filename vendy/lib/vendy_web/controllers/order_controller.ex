defmodule VendyWeb.OrderController do
  use VendyWeb, :controller
  alias Vendy.Sales

  def index(conn, _params) do
    customer = conn.assigns.current_customer
    orders = Sales.get_orders_by_customer(customer)
    render(conn, "index.html", orders: orders)
  end

  def show(conn, %{"order_id" => order_id}) do
    order = Sales.get_order(order_id)
    case order do
      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(VendyWeb.ErrorView)
        |> render("404.html")
      _ ->
        render(conn, "show.html", order: order)
    end
  end
end
