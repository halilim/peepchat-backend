defmodule Peepchat.UserController do
  use Peepchat.Web, :controller

  alias Peepchat.UserView

  plug Guardian.Plug.EnsureAuthenticated, handler: Peepchat.AuthErrorHandler

  def current(conn, _) do
    render conn, UserView, "show.json-api", data: Guardian.Plug.current_resource(conn)
  end
end
