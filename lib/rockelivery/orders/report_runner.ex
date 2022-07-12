defmodule Rockelivery.Orders.ReportRunner do
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

  use GenServer
  require Logger

  alias Rockelivery.Orders.Report

  # CLIENT

  def start_link(_initial_stack) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(state) do
    schedule_report_generation()

    {:ok, state}
  end

  @impl true
  # RECEBE QUALQUER TIPO DE MENSAGEM
  def handle_info(:generate, state) do
    Logger.info("Report Runner Starterd....")

    Report.create()
    schedule_report_generation()

    {:noreply, state}
  end

  def schedule_report_generation do
    Process.send_after(self(), :generate, 1000 * 60)
  end
end
