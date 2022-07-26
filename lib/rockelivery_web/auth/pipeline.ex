defmodule RockeliveryWeb.Auth.Pipeline do
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
  use Guardian.Plug.Pipeline, otp_app: :rockelivery

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
