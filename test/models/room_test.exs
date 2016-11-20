defmodule Peepchat.RoomTest do
  use Peepchat.ModelCase

  alias Peepchat.Room

  @valid_attrs %{name: "a room", owner_id: 1}
  @invalid_attrs %{}

  test "validations" do
    assert {:name, "can't be blank"} in errors_on(%Room{}, %{email: ""})
    assert {:name, "should be at least 4 character(s)"}
      in errors_on(%Room{}, %{name: String.duplicate("*", 3)})
    assert {:owner_id, "can't be blank"} in errors_on(%Room{}, %{owner_id: nil})
  end

  test "changeset with valid attributes" do
    changeset = Room.changeset(%Room{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Room.changeset(%Room{}, @invalid_attrs)
    refute changeset.valid?
  end
end
