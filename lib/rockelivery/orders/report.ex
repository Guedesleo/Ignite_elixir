defmodule Rockelivery.Orders.Report do
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
  import Ecto.Query

  alias Rockelivery.{Item, Order, Repo}
  alias Rockelivery.Orders.TotalPrice

  @default_block_size 500

  def create(file_name \\ "report.csv") do
    query = from(order in Order, order_by: order.user_id)

    {:ok, order_list} =
      Repo.transaction(
        fn ->
          query
          |> Repo.stream(max_rows: @default_block_size)
          |> Stream.chunk_every(@default_block_size)
          |> Stream.flat_map(fn chunk -> Repo.preload(chunk, :items) end)
          |> Enum.map(&parse_line/1)
        end,
        timeout: :infinity
      )

    File.write(file_name, order_list)
  end

  defp parse_line(%Order{user_id: user_id, payment_method: payment_method, items: items}) do
    items_string = Enum.map(items, &item_string/1)
    total_price = TotalPrice.calculate_total_price(items)

    "#{user_id},#{payment_method},#{items_string}#{total_price}\n"
  end

  defp item_string(%Item{category: category, description: description, price: price}) do
    "#{category},#{description},#{price},"
  end
end
