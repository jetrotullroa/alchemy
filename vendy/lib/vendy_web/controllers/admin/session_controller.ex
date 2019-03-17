defmodule VendyWeb.Admin.SessionController do
  use VendyWeb, :controller
  alias Vendy.Administration
  import Phoenix.HTML.Link, only: [link: 2]

  plug(:set_layout)

  def new(conn, _params), do: render(conn, "new.html")

  def create(conn, %{"token" => token_params}) do
    case verify_token(token_params) do
      {:ok, admin_id} ->
        admin = Administration.get_user!(admin_id)

        conn
        |> assign(:current_admin, admin)
        |> put_session(:admin_id, admin.id)
        |> configure_session(renew: true)
        |> put_flash(:info, "Successfully logged in!")
        |> redirect(to: admin_user_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:error, "Invalid Token")
        |> render(:new)
    end
  end

  def send_link(conn, %{"session" => session_params}) do
    case Administration.get_admin_by_email(session_params["email"]) do
      nil ->
        conn
        |> put_flash(:error, "Authentication Error")
        |> render("new.html")

      admin ->
        link = generate_login_link(conn, admin)

        conn
        |> put_flash(:info, ["Login using your magic link: ", link("Click me!", to: "#{link}")])
        |> render("new.html")
    end
  end

  # 10mins
  @max_age 600
  defp verify_token(token) do
    Phoenix.Token.verify(VendyWeb.Endpoint, "admin", token, max_age: @max_age)
  end

  defp generate_login_link(conn, admin) do
    token = Phoenix.Token.sign(VendyWeb.Endpoint, "admin", admin.id)
    admin_session_url(conn, :create, %{token: token})
  end

  defp set_layout(conn, _config), do: put_layout(conn, "admin_login.html")
end
