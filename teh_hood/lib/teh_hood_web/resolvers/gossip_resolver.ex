defmodule TehHoodWeb.GossipResolver do
  alias TehHood.Gossip

  def all_links(_root, _args, _info) do
    links = Gossip.list_links()
    {:ok, links}
  end

  def create_link(_root, args, _info) do
    case Gossip.create_link(args) do
      {:ok, link} ->
        {:ok, link }
      _error ->
        {:error, "could not create a link"}
    end
  end
  
end
