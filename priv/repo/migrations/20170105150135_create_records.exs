defmodule Ratex.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:records, primary_key: false) do
      add :id, :string, primary_key: true
      add :timestamp, :string
      add :state, :string
      add :district, :string
      add :market, :string
      add :commodity, :string
      add :variety, :string
      add :arrival_date, :string
      add :min_price, :string
      add :max_price, :string
      add :modal_price, :string

      timestamps()
    end
  end
end
