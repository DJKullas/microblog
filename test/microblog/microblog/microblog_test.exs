defmodule Microblog.MicroblogTest do
  use Microblog.DataCase

  alias Microblog.Microblog

  describe "users" do
    alias Microblog.Microblog.User

    @valid_attrs %{email: "some email", handle: "some handle", name: "some name", password: "some password"}
    @update_attrs %{email: "some updated email", handle: "some updated handle", name: "some updated name", password: "some updated password"}
    @invalid_attrs %{email: nil, handle: nil, name: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Microblog.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Microblog.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Microblog.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Microblog.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.handle == "some handle"
      assert user.name == "some name"
      assert user.password == "some password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Microblog.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Microblog.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.handle == "some updated handle"
      assert user.name == "some updated name"
      assert user.password == "some updated password"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Microblog.update_user(user, @invalid_attrs)
      assert user == Microblog.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Microblog.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Microblog.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Microblog.change_user(user)
    end
  end
end
