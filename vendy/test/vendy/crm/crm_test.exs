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

end
