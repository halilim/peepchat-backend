defmodule Peepchat.UserView do
  use Peepchat.Web, :view

  def type(_user,_conn), do: "users"

  attributes [:email]
  has_many :rooms, link: :rooms_link

  def rooms_link(user, conn) do
    user_rooms_url(conn, :index, user.id)
  end
end
