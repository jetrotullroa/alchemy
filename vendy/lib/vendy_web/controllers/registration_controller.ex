defmodule VendyWeb.RegistrationController do
  use VendyWeb, :controller
  alias Vendy.CRM

  def new(conn, _params) do
    changeset = CRM.build_customer()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"registration" => registration_data}) do
    case CRM.create_customer(registration_data) do
      {:ok, customer} ->
        conn
        |> put_flash(:info, "Registration Successful!")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        conn
        |> render(:new, changeset: changeset)
    end
  end
end
