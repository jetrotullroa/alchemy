defmodule TehHood.GossipTest do
  use TehHood.DataCase

  alias TehHood.Gossip

  describe "links" do
    alias TehHood.Gossip.Link

    @valid_attrs %{description: "some description", url: "some url"}
    @update_attrs %{description: "some updated description", url: "some updated url"}
    @invalid_attrs %{description: nil, url: nil}

    def link_fixture(attrs \\ %{}) do
      {:ok, link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Gossip.create_link()

      link
    end

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Gossip.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Gossip.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      assert {:ok, %Link{} = link} = Gossip.create_link(@valid_attrs)
      assert link.description == "some description"
      assert link.url == "some url"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Gossip.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      assert {:ok, link} = Gossip.update_link(link, @update_attrs)
      assert %Link{} = link
      assert link.description == "some updated description"
      assert link.url == "some updated url"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Gossip.update_link(link, @invalid_attrs)
      assert link == Gossip.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Gossip.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Gossip.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Gossip.change_link(link)
    end
  end
end
