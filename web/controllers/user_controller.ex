defmodule Peepchat.UserController do
  use Peepchat.Web, :controller

  alias Peepchat.UserView

  plug Guardian.Plug.EnsureAuthenticated, handler: Peepchat.AuthErrorHandler

  def index(conn, _) do
    users = Repo.all(User)
    render(conn, "index.json-api", data: users)
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.json-api", data: user)
  end

  def current(conn, _) do
    render conn, "show.json-api", data: Guardian.Plug.current_resource(conn)
  end
end
