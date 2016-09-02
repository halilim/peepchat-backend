defmodule Peepchat.UserView do
  use Peepchat.Web, :view

  def type(_user,_conn), do: "users"

  attributes [:email]
end
