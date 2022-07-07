defmodule Rockelivery.Orders.ReportRunner do

  use GenServer
  require Logger

  alias Rockelivery.Orders.Report

  #CLIENT

  def start_lin(_initial_stack)  do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(state)do
    schedule_report_generation()

    {:ok, state}
  end

  @impl true
  #RECEBE QUALQUER TIPO DE MENSAGEM
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
