defmodule Rockelivery.Stack do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use RockeliveryWeb, :controller
      use RockeliveryWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """
  use GenServer

  # CLIENT

  def start_lin(initial_stack) when is_list(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack)
  end

  def push(pid, element) do
    GenServer.cast(pid, {:push, element})
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  # Server(Callbacks)

  @impt true
  def init(stack) do
    {:ok, stack}
  end

  @impt true
  # SYNC
  def handle_call({:push, element}, _from, stack) do
    new_stack = [element | stack]
    {:reply, new_stack, new_stack}
  end

  @impt true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impt true
  def handle_call(:pop, _from, []) do
    {:reply, nil, []}
  end

  # ASYNC
  def handle_cast({:push, element}, stack) do
    {:noreply, [element | stack]}
  end
end
