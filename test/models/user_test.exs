defmodule Peepchat.UserTest do
  use Peepchat.ModelCase

  alias Peepchat.User

  @valid_attrs %{email: "a@b.c", password: "12345678", password_confirmation: "12345678"}
  @invalid_attrs %{}

  test "validations" do
    assert {:email, "can't be blank"} in errors_on(%User{}, %{email: ""})
    assert {:password, "can't be blank"} in errors_on(%User{}, %{password: ""})
    assert {:password_confirmation, "can't be blank"}
      in errors_on(%User{}, %{password_confirmation: ""})
    assert {:email, "has invalid format"} in errors_on(%User{}, %{email: "a"})
    assert {:password, "should be at least 8 character(s)"}
      in errors_on(%User{}, %{password: String.duplicate("*", 7)})
    assert {:password_confirmation, "does not match confirmation"}
      in errors_on(%User{}, %{password: "something", password_confirmation: "else"})
  end

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
