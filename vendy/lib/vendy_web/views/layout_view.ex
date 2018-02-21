defmodule VendyWeb.LayoutView do
  use VendyWeb, :view
  import VendyWeb.CartView, only: [cart_count: 1]
end
