defmodule MicroblogWeb.FollowerControllerTest do
  use MicroblogWeb.ConnCase

  alias Microblog.Blog

  @create_attrs %{email_me: "some email_me", email_owner: "some email_owner"}
  @update_attrs %{email_me: "some updated email_me", email_owner: "some updated email_owner"}
  @invalid_attrs %{email_me: nil, email_owner: nil}

  def fixture(:follower) do
    {:ok, follower} = Blog.create_follower(@create_attrs)
    follower
  end

  describe "index" do
    test "lists all followers", %{conn: conn} do
      conn = get conn, follower_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Followers"
    end
  end

  describe "new follower" do
    test "renders form", %{conn: conn} do
      conn = get conn, follower_path(conn, :new)
      assert html_response(conn, 200) =~ "New Follower"
    end
  end

  describe "create follower" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, follower_path(conn, :create), follower: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == follower_path(conn, :show, id)

      conn = get conn, follower_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Follower"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, follower_path(conn, :create), follower: @invalid_attrs
      assert html_response(conn, 200) =~ "New Follower"
    end
  end

  describe "edit follower" do
    setup [:create_follower]

    test "renders form for editing chosen follower", %{conn: conn, follower: follower} do
      conn = get conn, follower_path(conn, :edit, follower)
      assert html_response(conn, 200) =~ "Edit Follower"
    end
  end

  describe "update follower" do
    setup [:create_follower]

    test "redirects when data is valid", %{conn: conn, follower: follower} do
      conn = put conn, follower_path(conn, :update, follower), follower: @update_attrs
      assert redirected_to(conn) == follower_path(conn, :show, follower)

      conn = get conn, follower_path(conn, :show, follower)
      assert html_response(conn, 200) =~ "some updated email_me"
    end

    test "renders errors when data is invalid", %{conn: conn, follower: follower} do
      conn = put conn, follower_path(conn, :update, follower), follower: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Follower"
    end
  end

  describe "delete follower" do
    setup [:create_follower]

    test "deletes chosen follower", %{conn: conn, follower: follower} do
      conn = delete conn, follower_path(conn, :delete, follower)
      assert redirected_to(conn) == follower_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, follower_path(conn, :show, follower)
      end
    end
  end

  defp create_follower(_) do
    follower = fixture(:follower)
    {:ok, follower: follower}
  end
end
