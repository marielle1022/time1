defmodule Time1.UsersTest do
  use Time1.DataCase

  alias Time1.Users

  describe "users" do
    alias Time1.Users.User

    # when users didn't have username field
    # @valid_attrs %{manager: "some manager", name: "some name", role: "some role"}
    # @update_attrs %{manager: "some updated manager", name: "some updated name", role: "some updated role"}
    # @invalid_attrs %{manager: nil, name: nil, role: nil}

    @valid_attrs %{
      username: "some username",
      name: "some name",
      role: "some role",
      manager: "some manager"
    }
    @update_attrs %{
      username: "some updated username",
      name: "some updated name",
      role: "some updated role",
      manager: "some updated manager"
    }
    @invalid_attrs %{username: nil, name: nil, role: nil, manager: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.username == "some username"
      assert user.name == "some name"
      assert user.role == "some role"
      assert user.manager == "some manager"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
      assert user.username == "some updated username"
      assert user.name == "some updated name"
      assert user.role == "some updated role"
      assert user.manager == "some updated manager"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
