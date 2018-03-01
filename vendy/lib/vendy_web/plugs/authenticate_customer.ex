defmodule VendyWeb.Plugs.AuthenticateCustomer do
  import Plug.Conn
  import Phoenix.Controller, only: [redirect: 2, put_flash: 3]

  def init(_opts), do: nil

  def call(conn, _opts) do
    case conn.assigns[:current_customer] do
      nil ->
        conn
        |> put_flash(:info, "You must be logged in to continue this action.")
        |> redirect(to: "/login")
        |> halt
      _ ->
        conn
    end
  end
end
