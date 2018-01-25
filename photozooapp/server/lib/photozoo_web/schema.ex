defmodule PhotozooWeb.Schema do
  use Absinthe.Schema

  alias PhotozooWeb.Resolvers

  import_types PhotozooWeb.Schema.PostsTypes

  query do
    @desc get all posts
    field :photos, list_of(:photo) do
      resolve &Resolvers.Posts.photos/3
    end

    @desc get single post via id
    field :photo, :photo do
      reslove &Resolvers.Posts.photos/3
    end
  end
end
