defmodule Rockelivery do
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
  alias Rockelivery.Items.Create, as: ItemCreate

  alias Rockelivery.Orders.Create, as: OrderCreate

  alias Rockelivery.Users.Create, as: UserCreate
  alias Rockelivery.Users.Delete, as: UserDelete
  alias Rockelivery.Users.Get, as: GetUser
  alias Rockelivery.Users.Update, as: UserUpdate

  defdelegate create_item(params), to: ItemCreate, as: :call

  defdelegate create_order(params), to: OrderCreate, as: :call

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate delete_user(id), to: UserDelete, as: :call
  defdelegate update_user(params), to: UserUpdate, as: :call
  defdelegate get_user_by_id(id), to: GetUser, as: :by_id
end
