defmodule Peepchat.UserControllerTest do
  use Peepchat.ConnCase

  alias Peepchat.User
  alias Peepchat.UserView

  test "returns the current user with valid auth headers", %{conn: conn} do
    user = Repo.insert!(%User{email: "mike@example.com",
      password: "fqhi12hrrfasf",
      password_confirmation: "fqhi12hrrfasf"})

    {:ok, token, _} = user |> Guardian.encode_and_sign

    conn = conn
    |> put_req_header("authorization", token)
    |> get(current_user_path(conn, :current))

    assert json_response(conn, 200) == UserView.render("show.json-api", %{data: user})
  end

  test "returns 401 Unauthorized without valid auth headers", %{conn: conn} do
    conn = get conn, current_user_path(conn, :current)

    assert json_response(conn, 401) == %{"errors" => [%{"code" => 401, "title" => "Unauthorized"}]}
  end
end
