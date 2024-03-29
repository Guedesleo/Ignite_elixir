defmodule Rockelivery.Orders.TotalPrice do
  alias Rockelivery.Item

  def calculate_total_price(items) do
    Enum.reduce(items, Decimal.new("0.00"), &sum_prices(&1, &2))
  end

  defp sum_prices(%Item{price: price}, acc), do: Decimal.add(price, acc)
end
