defmodule VendyWeb.Acceptance.SessionTest do
  use Vendy.DataCase
  use Hound.Helpers
  alias Vendy.CRM

  hound_session()

  setup do
    valid_attrs = %{
      "name" => "John Doe",
      "email" => "johndoe@example.com",
      "password" => "secrets",
      "residence_area" => "Area 1",
      "phone" => "2222"
    }
    {:ok, _customer} = CRM.create_customer(valid_attrs)
    :ok
  end

  test "show sucessfully login" do
    navigate_to("/login")
    form = find_element(:id, "session-form")
    find_within_element(form, :name, "session[email]") |> fill_field("johndoe@example.com")
    find_within_element(form, :name, "session[password]") |> fill_field("secrets")
    find_within_element(form, :tag, "button") |> click

    assert current_path == "/"
    message = find_element(:class, "alert") |> visible_text
    assert message == "Login successful!"
  end

  test "show error for invalid credentials" do
    navigate_to("/login")
    form = find_element(:id, "session-form")
    find_within_element(form, :tag, "button") |> click

    message = find_element(:class, "alert") |> visible_text
    assert message == "Invalid user email/password combination"
  end

  test "show logout message" do
    navigate_to("/logout")

  message = find_element(:class, "alert") |> visible_text
    assert message == "You are successfully logged out."
  end
end
