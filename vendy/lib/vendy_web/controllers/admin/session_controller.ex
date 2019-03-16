defmodule VendyWeb.Admin.SessionController do
  use VendyWeb, :controller
  plug(:set_layout)

  def new(conn, _params), do: render(conn, "new.html")

  defp set_layout(conn, _config), do: put_layout(conn, "admin_login.html")
end
