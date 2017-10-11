# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TehHood.Repo.insert!(%TehHood.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TehHood.Gossip.Link
alias TehHood.Repo

%Link{url: "https://elixir-lang.org/", description: "The New Hipster Language in teh Hoodz"} |> Repo.insert
%Link{url: "http://phoenixframework.org/", description: "A productive web framework that
does not compromise speed and maintainability."} |> Repo.insert
