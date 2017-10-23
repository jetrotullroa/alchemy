defmodule VendyWeb.PageController do
  use VendyWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
