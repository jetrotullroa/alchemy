defmodule VendyWeb.SessionController do
  use VendyWeb, :controller
  alias Vendy.CRM

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_data}) do
    case CRM.get_customer_by_credentials(session_data) do
      :error ->
        conn
        |> put_flash(:error, "Invalid user email/password combination")
        |> render("new.html")
      customer ->
        path = get_session(conn, :intendent_path) || page_path(conn, :index)
        conn
        |> assign(:current_customer, customer)
        |> put_session(:customer_id, customer.id)
        |> configure_session(renew: true)
        |> put_flash(:info, "Login successful!")
        |> redirect(to: path)
    end
  end

  def delete(conn, _params) do
    clear_session(conn)
    |>put_flash(:info, "You are successfully logged out.")
    |> redirect(to: page_path(conn, :index))
  end
end
