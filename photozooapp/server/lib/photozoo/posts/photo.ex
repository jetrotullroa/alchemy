defmodule Photozoo.Posts.Photo do
  use Ecto.Schema
  import Ecto.Changeset
  alias Photozoo.Posts.Photo


  schema "photos" do
    field :caption, :string
    field :image_url, :string

    timestamps()
  end

  @doc false
  def changeset(%Photo{} = photo, attrs) do
    photo
    |> cast(attrs, [:image_url, :caption])
    |> validate_required([:image_url])
  end
end
