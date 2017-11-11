defmodule VendyWeb.Plugs.LoadCustomer do
  import Plug.Conn
  alias Vendy.CRM

  def init(_opts), do: nil

  def call(conn, _opts) do
    customer_id = get_session(conn, :customer_id)
    customer = customer_id && CRM.get_customer_by_id(customer_id)

    assign(conn, :current_customer, customer)
  end

end
