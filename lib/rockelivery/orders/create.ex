defmodule Rockelivery.Orders.Create do
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
  alias Rockelivery.{Error, Order, Repo}
  alias Rockelivery.Items.GetAllById, as: GetAllItemsById
  alias Rockelivery.Orders.ValidateAndMultiplyItems

  def call(%{"items" => items_params} = params) do
    items_ids = Enum.map(items_params, fn item -> item["id"] end)

    items_ids
    |> GetAllItemsById.call()
    |> ValidateAndMultiplyItems.call(items_ids, items_params)
    |> handle_items(params)
  end

  defp handle_items({:error, _result} = error, _params), do: error

  defp handle_items({:ok, items}, params) do
    params
    |> Order.changeset(items)
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Order{}} = result), do: result
  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}
end
