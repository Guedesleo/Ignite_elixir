defmodule RockeliveryWeb.Auth.ErrorHandler do
  alias Guardian.Plug.ErrorHandler
  alias Plug.Conn

  @behaviour ErrorHandler

  def auth_error(conn, {error, _reason}, _opts) do
    body = Jason.encode!(%{code: "X02", field: "basic token"})

    Conn.send_resp(conn, 401, body)
  end
end
