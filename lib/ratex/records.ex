defmodule Ratex.Record do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :string, []}
  schema "records" do
    field :timestamp, :string
    field :state, :string
    field :district, :string
    field :market, :string
    field :commodity, :string
    field :variety, :string
    field :arrival_date, :string
    field :min_price, :string
    field :max_price, :string
    field :modal_price, :string

    timestamps()
  end


  @fields ~w(id state district market commodity variety arrival_date min_price max_price modal_price timestamp)a

  def changeset(record, params \\ %{}) do
    record
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:id)
  end
end
