defmodule Rockelivery.Item do
  @moduledoc """
  This module defines the test case to be used by
  channel tests.

  Such tests rely on `Phoenix.ChannelTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use RockeliveryWeb.ChannelCase, async: true`, although
  this option is not recommended for other databases.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Enum
  alias Rockelivery.Order

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:category, :description, :price, :photo]

  @items_categories [:food, :drink, :deserves]

  @derive {Jason.Encoder, only: [:id, :category, :description, :price, :photo]}

  schema "items" do
    field(:category, Enum, values: @items_categories)
    field(:description, :string)
    field(:price, :decimal)
    field(:photo, :string)

    many_to_many(:orders, Order, join_through: "orders_items")

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> handle_changes(params, @required_params)
  end

  defp handle_changes(struct, params, fields) do
    struct
    |> cast(params, fields)
    |> validate_required(fields)
    |> validate_length(:description, min: 6)
    |> validate_number(:price, greater_than: 0)
  end
end
