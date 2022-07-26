defmodule RockeliveryWeb.ChannelCase do
  use ExUnit.CaseTemplate
  alias Ecto.Adapters.SQL.Sandbox

  using do
    quote do
      # Import conveniences for testing with channels
      import Phoenix.ChannelTest
      import RockeliveryWeb.ChannelCase

      # The default endpoint for testing
      @endpoint RockeliveryWeb.Endpoint
    end
  end

  setup tags do
    pid = Sandbox.start_owner!(Rockelivery.Repo, shared: not tags[:async])
    on_exit(fn -> Sandbox.stop_owner(pid) end)
    :ok
  end
end
