defmodule Vendy.Repo.Migrations.AddCheckoutFieldsToOrders do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :comments, :text
      add :customer_id, references(:customers)
      add :customer_name, :string
      add :customer_email, :string
      add :residence_area, :string
    end
    create index(:orders, [:customer_id])
  end
end
