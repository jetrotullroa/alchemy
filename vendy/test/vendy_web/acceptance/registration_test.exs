defmodule VendyWeb.Acceptance.RegistrationTest do
  use Vendy.DataCase
  use Hound.Helpers
  alias Vendy.CRM

  hound_session()

  test "register an account with valid data" do
    navigate_to("/register")
    form = find_element(:id, "registration-form")
    find_within_element(form, :name, "registration[name]") |> fill_field("John")
    find_within_element(form, :name, "registration[email]") |> fill_field("john@example.com")
    find_within_element(form, :name, "registration[phone]") |> fill_field("1111")
    find_within_element(form, :name, "registration[residence_area]") |> fill_field("Area 1")
    find_within_element(form, :name, "registration[password]") |> fill_field("password")
    find_within_element(form, :tag, "button") |> click

    assert current_path == "/"
    message = find_element(:class, "alert") |> visible_text()
    assert message = "Registration Successful!"
  end

  test "register an account with invalid/empty data" do
    navigate_to("/register")
    form = find_element(:id, "registration-form")
    find_within_element(form, :tag, "button") |> click

    assert current_path == "/register"
    message = find_element(:class, "alert") |> visible_text()
    assert message == "Oops, something went wrong! Please check the errors below."
  end

  test "create_customer/1 returns a customer for valid data" do
    valid_attrs = %{
      "name" => "John Doe",
      "email" => "johndoe@example.com",
      "password" => "secret",
      "residence_area" => "Area 1",
      "phone" => "1111"
    }

    assert {:ok, customer} = CRM.create_customer(valid_attrs)
    assert Comeonin.Bcrypt.checkpw(valid_attrs["password"], customer.password_hash)
  end

  test "create_customer/1 returns a changeset for invalid data" do
    invalid_attrs = %{}

    assert {:error, %Ecto.Changeset{}} = CRM.create_customer(invalid_attrs)
  end
end
