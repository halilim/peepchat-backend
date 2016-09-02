defmodule Peepchat.UserTest do
  use Peepchat.ModelCase

  alias Peepchat.User

  Enum.each([
      %{message: "valid attributes",
        attrs: %{email: "user@example.com", password: "abdc1234", password_confirmation: "abdc1234"},
        valid: true},
      %{message: "invalid attributes",
        attrs: %{},
        valid: false},
      %{message: "mismatched password confirmation",
        attrs: %{email: "user@example.com", password: "abdc1234", password_confirmation: "abdc1235"},
        valid: false},
      %{message: "missing password confirmation",
        attrs: %{email: "user@example.com", password: "abdc1234"},
        valid: false},
      %{message: "a short password",
        attrs: %{email: "user@example.com", password: "abdc123", password_confirmation: "abdc123"},
        valid: false}
    ],
    fn (test_case) ->
      @test_case test_case
      test "changeset with #{test_case[:message]}" do
        result = User.changeset(%User{}, @test_case[:attrs]).valid?
        case @test_case[:valid] do
          true -> assert result
          false -> refute result
        end
      end
    end
  )
end
