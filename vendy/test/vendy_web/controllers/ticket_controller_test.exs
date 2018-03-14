defmodule VendyWeb.TicketControllerTest do
  use VendyWeb.ConnCase

  alias Vendy.CRM

  @create_attrs %{message: "some message", status: "some status", subject: "some subject"}
  @update_attrs %{message: "some updated message", status: "some updated status", subject: "some updated subject"}
  @invalid_attrs %{message: nil, status: nil, subject: nil}

  def fixture(:ticket) do
    {:ok, ticket} = CRM.create_ticket(@create_attrs)
    ticket
  end

  describe "index" do
    test "lists all tickets", %{conn: conn} do
      conn = get conn, ticket_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Tickets"
    end
  end

  describe "new ticket" do
    test "renders form", %{conn: conn} do
      conn = get conn, ticket_path(conn, :new)
      assert html_response(conn, 200) =~ "New Ticket"
    end
  end

  describe "create ticket" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, ticket_path(conn, :create), ticket: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ticket_path(conn, :show, id)

      conn = get conn, ticket_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Ticket"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, ticket_path(conn, :create), ticket: @invalid_attrs
      assert html_response(conn, 200) =~ "New Ticket"
    end
  end

  defp create_ticket(_) do
    ticket = fixture(:ticket)
    {:ok, ticket: ticket}
  end
end
