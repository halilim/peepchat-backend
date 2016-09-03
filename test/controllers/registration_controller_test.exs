defmodule Peepchat.RegistrationControllerTest do
  use Peepchat.ConnCase

  alias Peepchat.User

  @valid_attrs %{
    "email" => "mike@example.com",
    "password" => "fqhi12hrrfasf",
    "password-confirmation" => "fqhi12hrrfasf"
  }

  @invalid_attrs %{
    "email" => "joe",
    "password" => "",
    "password-confirmation" => ""
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/vnd.api+json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, registration_path(conn, :create), %{data: %{type: "users",
      attributes: @valid_attrs
    }}
    assert json_response(conn, :created)["data"]["id"]
    assert Repo.get_by(User, %{email: @valid_attrs["email"]})
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, registration_path(conn, :create),  %{data: %{type: "users",
      attributes: @invalid_attrs
    }}

    assert response(conn, :unprocessable_entity) ==
      Peepchat.ChangesetView.render("error.json-api",
        changeset: User.changeset(%User{}, @invalid_attrs))
      |> Poison.encode!
    refute Repo.get_by(User, %{email: @valid_attrs["email"]})
  end

  test "renders bad request when data is missing", %{conn: conn} do
    conn = post conn, registration_path(conn, :create),  %{data: %{type: "users", attributes: %{}}}

    assert response(conn, :bad_request) == Peepchat.ErrorView.render("400.json") |> Poison.encode!
  end
end
