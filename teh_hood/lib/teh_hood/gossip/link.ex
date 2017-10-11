defmodule TehHood.Gossip.Link do
  use Ecto.Schema
  import Ecto.Changeset
  alias TehHood.Gossip.Link


  schema "links" do
    field :description, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(%Link{} = link, attrs) do
    link
    |> cast(attrs, [:url, :description])
    |> validate_required([:url, :description])
  end
end
