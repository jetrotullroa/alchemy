defmodule VendyWeb.RegistrationController do
  use VendyWeb, :controller
  alias Vendy.CRM

  def new(conn, _params) do
    changeset = CRM.build_customer()
    residence_areas = Auroville.ResidenceService.list_areas
    render(conn, "new.html", changeset: changeset, residence_areas: residence_areas)
  end

  def create(conn, %{"registration" => registration_data}) do
    case CRM.create_customer(registration_data) do
      {:ok, customer} ->
        conn
        |> put_flash(:info, "Registration Successful!")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        residence_areas = Auroville.ResidenceService.list_areas
        conn
        |> render(:new, changeset: changeset, residence_areas: residence_areas)
    end
  end
end
