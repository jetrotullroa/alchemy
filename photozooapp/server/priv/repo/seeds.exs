# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Photozoo.Repo.insert!(%Photozoo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Photozoo.{Posts, Repo}

photo_list = [
  "https://freestocks.org/photo/cow-in-the-meadow/",
  "https://freestocks.org/fs/wp-content/uploads/2017/01/cat_and_cactus-800x533.jpg",
  "https://freestocks.org/fs/wp-content/uploads/2016/12/Winter-duck-800x533.jpg",
  "https://freestocks.org/fs/wp-content/uploads/2015/07/german_shepherd-800x533.jpg",
  "https://freestocks.org/fs/wp-content/uploads/2017/08/baby_goat_eating_lubine-800x533.jpg"
]

for idx <- 0..4 do
  photo = %{
    image_url: Enum.at(photo_list, idx),
    caption: Faker.Lorem.Shakespeare.hamlet
  }

  %Posts.Photo{}
  |> Posts.Photo.changeset(photo)
  |> Repo.insert!
end
