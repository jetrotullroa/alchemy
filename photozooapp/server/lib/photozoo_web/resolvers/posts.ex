defmodule PhotozooWeb.Resolvers.Posts do

  def photos(_,_,_) do
    {:ok, Photozoo.Posts.list_photos}
  end

  def photo(_,{id: id}, _) do
    {:ok, Photozoo.Posts.get_photo!(id)}
  end

end
