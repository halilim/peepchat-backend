defmodule Peepchat.RegistrationController do
  use Peepchat.Web, :controller

  alias Peepchat.User

  def create(conn, %{"data" => %{"type" => "users",
    "attributes" => %{"email" => email,
      "password" => password,
      "password-confirmation" => password_confirmation}}}) do

    changeset = User.changeset(%User{}, %{email: email,
      password_confirmation: password_confirmation,
      password: password})

    case Repo.insert changeset do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render(Peepchat.UserView, "show.json-api", data: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Peepchat.ChangesetView, "error.json-api", changeset: changeset)
    end
  end

  def create(conn, _) do
    conn
    |> put_status(:bad_request)
    |> render(Peepchat.ErrorView, "400.json")
  end
end
