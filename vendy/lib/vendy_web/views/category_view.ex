defmodule VendyWeb.CategoryView do
  use VendyWeb, :view

  def title_capitalize(title) do
    title
    |> String.downcase
    |> String.capitalize
  end
end
