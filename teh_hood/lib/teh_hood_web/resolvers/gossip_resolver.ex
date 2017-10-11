defmodule TehHoodWeb.GossipResolver do
  alias TehHood.Gossip

  def all_links(_root, _args, _info) do
    links = Gossip.list_links()
    {:ok, links}
  end
end
