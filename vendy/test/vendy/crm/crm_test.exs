defmodule Vendy.CRMTest do
  use Vendy.DataCase
  alias Vendy.CRM
  alias Vendy.CRM.Customer

  test "build_customer/0 return an empty customer" do
    assert %Ecto.Changeset{ data: %Customer{} } = CRM.build_customer
  end

  test "build_customer/1 return a customer with value" do
    attrs = %{"name" => "John Doe"}
    changeset = CRM.build_customer(attrs)
    assert changeset.params == attrs
  end

  test "get_customer_by_email/1" do
    valid_attrs = %{
      "name" => "John Doe",
      "email" => "johndoe@example.com",
      "password" => "secret",
      "residence_area" => "Area 1",
      "phone" => "2222"
    }
    {:ok, customer1} = CRM.create_customer(valid_attrs)
    customer2 = CRM.get_customer_by_email("johndoe@example.com")
    assert customer1.id == customer2.id
  end

  test "get_customer_by_credentials/1" do
    valid_attrs = %{
      "name" => "John Doe",
      "email" => "johndoe@example.com",
      "password" => "secret",
      "residence_area" => "Area 1",
      "phone" => "2222"
    }
    {:ok, customer1} = CRM.create_customer(valid_attrs)
    customer2 = CRM.get_customer_by_credentials(%{"email" => "johndoe@example.com", "password" => "secret"})
    assert customer1.id == customer2.id
  end

end
