defmodule VendyWeb.Plugs.LoadCustomerTest do
  use VendyWeb.ConnCase
  alias Vendy.CRM

  @valid_attrs %{
    "name" => "John Doe",
    "email" => "johndoe@example.com",
    "password" => "secret",
    "residence_area" => "Area 1",
    "phone" => "11111"
  }

  test "fetch customer from session on subsequent visit" do
    {:ok, customer} = CRM.create_customer(@valid_attrs)
    conn = post build_conn, "/login", %{"session" => @valid_attrs}
    conn = get conn, "/"

    assert customer.id == conn.assigns.current_customer.id
  end
end
