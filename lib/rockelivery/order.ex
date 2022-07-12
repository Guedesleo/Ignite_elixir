defmodule Rockelivery.Order do
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
  alias Rockelivery.{Item, User}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:address, :comments, :payment_method, :user_id]
  @payment_methods [:money, :credit_card, :debit_card]

  @derive {Jason.Encoder, only: @required_params ++ [:id, :items]}

  schema "orders" do
    field(:address, :string)
    field(:comments, :string)
    field(:payment_method, Enum, values: @payment_methods)

    many_to_many(:items, Item, join_through: "orders_items")
    belongs_to(:user, User)

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params, items) do
    struct
    |> handle_changes(params, @required_params, items)
  end

  defp handle_changes(struct, params, fields, items) do
    struct
    |> cast(params, fields)
    |> put_assoc(:items, items)
    |> validate_required(fields)
    |> validate_length(:address, min: 10)
    |> validate_length(:comments, min: 6)
  end
end
