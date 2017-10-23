defmodule Microblog.BlogTest do
  use Microblog.DataCase

  alias Microblog.Blog

  describe "posts" do
    alias Microblog.Blog.Post

    @valid_attrs %{message: "some message", time: "2010-04-17 14:00:00.000000Z", user: "some user"}
    @update_attrs %{message: "some updated message", time: "2011-05-18 15:01:01.000000Z", user: "some updated user"}
    @invalid_attrs %{message: nil, time: nil, user: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blog.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Blog.create_post(@valid_attrs)
      assert post.message == "some message"
      assert post.time == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert post.user == "some user"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Blog.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.message == "some updated message"
      assert post.time == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert post.user == "some updated user"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end

  describe "users" do
    alias Microblog.Blog.User

    @valid_attrs %{email: "some email", handle: "some handle", name: "some name", password: "some password"}
    @update_attrs %{email: "some updated email", handle: "some updated handle", name: "some updated name", password: "some updated password"}
    @invalid_attrs %{email: nil, handle: nil, name: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Blog.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Blog.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Blog.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.handle == "some handle"
      assert user.name == "some name"
      assert user.password == "some password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Blog.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.handle == "some updated handle"
      assert user.name == "some updated name"
      assert user.password == "some updated password"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_user(user, @invalid_attrs)
      assert user == Blog.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Blog.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Blog.change_user(user)
    end
  end

  describe "followers" do
    alias Microblog.Blog.Follower

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def follower_fixture(attrs \\ %{}) do
      {:ok, follower} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_follower()

      follower
    end

    test "list_followers/0 returns all followers" do
      follower = follower_fixture()
      assert Blog.list_followers() == [follower]
    end

    test "get_follower!/1 returns the follower with given id" do
      follower = follower_fixture()
      assert Blog.get_follower!(follower.id) == follower
    end

    test "create_follower/1 with valid data creates a follower" do
      assert {:ok, %Follower{} = follower} = Blog.create_follower(@valid_attrs)
    end

    test "create_follower/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_follower(@invalid_attrs)
    end

    test "update_follower/2 with valid data updates the follower" do
      follower = follower_fixture()
      assert {:ok, follower} = Blog.update_follower(follower, @update_attrs)
      assert %Follower{} = follower
    end

    test "update_follower/2 with invalid data returns error changeset" do
      follower = follower_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_follower(follower, @invalid_attrs)
      assert follower == Blog.get_follower!(follower.id)
    end

    test "delete_follower/1 deletes the follower" do
      follower = follower_fixture()
      assert {:ok, %Follower{}} = Blog.delete_follower(follower)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_follower!(follower.id) end
    end

    test "change_follower/1 returns a follower changeset" do
      follower = follower_fixture()
      assert %Ecto.Changeset{} = Blog.change_follower(follower)
    end
  end

  describe "following" do
    alias Microblog.Blog.Following

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def following_fixture(attrs \\ %{}) do
      {:ok, following} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_following()

      following
    end

    test "list_following/0 returns all following" do
      following = following_fixture()
      assert Blog.list_following() == [following]
    end

    test "get_following!/1 returns the following with given id" do
      following = following_fixture()
      assert Blog.get_following!(following.id) == following
    end

    test "create_following/1 with valid data creates a following" do
      assert {:ok, %Following{} = following} = Blog.create_following(@valid_attrs)
    end

    test "create_following/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_following(@invalid_attrs)
    end

    test "update_following/2 with valid data updates the following" do
      following = following_fixture()
      assert {:ok, following} = Blog.update_following(following, @update_attrs)
      assert %Following{} = following
    end

    test "update_following/2 with invalid data returns error changeset" do
      following = following_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_following(following, @invalid_attrs)
      assert following == Blog.get_following!(following.id)
    end

    test "delete_following/1 deletes the following" do
      following = following_fixture()
      assert {:ok, %Following{}} = Blog.delete_following(following)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_following!(following.id) end
    end

    test "change_following/1 returns a following changeset" do
      following = following_fixture()
      assert %Ecto.Changeset{} = Blog.change_following(following)
    end
  end

  describe "followers" do
    alias Microblog.Blog.Follower

    @valid_attrs %{email: "some email"}
    @update_attrs %{email: "some updated email"}
    @invalid_attrs %{email: nil}

    def follower_fixture(attrs \\ %{}) do
      {:ok, follower} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_follower()

      follower
    end

    test "list_followers/0 returns all followers" do
      follower = follower_fixture()
      assert Blog.list_followers() == [follower]
    end

    test "get_follower!/1 returns the follower with given id" do
      follower = follower_fixture()
      assert Blog.get_follower!(follower.id) == follower
    end

    test "create_follower/1 with valid data creates a follower" do
      assert {:ok, %Follower{} = follower} = Blog.create_follower(@valid_attrs)
      assert follower.email == "some email"
    end

    test "create_follower/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_follower(@invalid_attrs)
    end

    test "update_follower/2 with valid data updates the follower" do
      follower = follower_fixture()
      assert {:ok, follower} = Blog.update_follower(follower, @update_attrs)
      assert %Follower{} = follower
      assert follower.email == "some updated email"
    end

    test "update_follower/2 with invalid data returns error changeset" do
      follower = follower_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_follower(follower, @invalid_attrs)
      assert follower == Blog.get_follower!(follower.id)
    end

    test "delete_follower/1 deletes the follower" do
      follower = follower_fixture()
      assert {:ok, %Follower{}} = Blog.delete_follower(follower)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_follower!(follower.id) end
    end

    test "change_follower/1 returns a follower changeset" do
      follower = follower_fixture()
      assert %Ecto.Changeset{} = Blog.change_follower(follower)
    end
  end

  describe "following" do
    alias Microblog.Blog.Following

    @valid_attrs %{email: "some email"}
    @update_attrs %{email: "some updated email"}
    @invalid_attrs %{email: nil}

    def following_fixture(attrs \\ %{}) do
      {:ok, following} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_following()

      following
    end

    test "list_following/0 returns all following" do
      following = following_fixture()
      assert Blog.list_following() == [following]
    end

    test "get_following!/1 returns the following with given id" do
      following = following_fixture()
      assert Blog.get_following!(following.id) == following
    end

    test "create_following/1 with valid data creates a following" do
      assert {:ok, %Following{} = following} = Blog.create_following(@valid_attrs)
      assert following.email == "some email"
    end

    test "create_following/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_following(@invalid_attrs)
    end

    test "update_following/2 with valid data updates the following" do
      following = following_fixture()
      assert {:ok, following} = Blog.update_following(following, @update_attrs)
      assert %Following{} = following
      assert following.email == "some updated email"
    end

    test "update_following/2 with invalid data returns error changeset" do
      following = following_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_following(following, @invalid_attrs)
      assert following == Blog.get_following!(following.id)
    end

    test "delete_following/1 deletes the following" do
      following = following_fixture()
      assert {:ok, %Following{}} = Blog.delete_following(following)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_following!(following.id) end
    end

    test "change_following/1 returns a following changeset" do
      following = following_fixture()
      assert %Ecto.Changeset{} = Blog.change_following(following)
    end
  end

  describe "followers" do
    alias Microblog.Blog.Follower

    @valid_attrs %{email_me: "some email_me", email_owner: "some email_owner"}
    @update_attrs %{email_me: "some updated email_me", email_owner: "some updated email_owner"}
    @invalid_attrs %{email_me: nil, email_owner: nil}

    def follower_fixture(attrs \\ %{}) do
      {:ok, follower} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_follower()

      follower
    end

    test "list_followers/0 returns all followers" do
      follower = follower_fixture()
      assert Blog.list_followers() == [follower]
    end

    test "get_follower!/1 returns the follower with given id" do
      follower = follower_fixture()
      assert Blog.get_follower!(follower.id) == follower
    end

    test "create_follower/1 with valid data creates a follower" do
      assert {:ok, %Follower{} = follower} = Blog.create_follower(@valid_attrs)
      assert follower.email_me == "some email_me"
      assert follower.email_owner == "some email_owner"
    end

    test "create_follower/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_follower(@invalid_attrs)
    end

    test "update_follower/2 with valid data updates the follower" do
      follower = follower_fixture()
      assert {:ok, follower} = Blog.update_follower(follower, @update_attrs)
      assert %Follower{} = follower
      assert follower.email_me == "some updated email_me"
      assert follower.email_owner == "some updated email_owner"
    end

    test "update_follower/2 with invalid data returns error changeset" do
      follower = follower_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_follower(follower, @invalid_attrs)
      assert follower == Blog.get_follower!(follower.id)
    end

    test "delete_follower/1 deletes the follower" do
      follower = follower_fixture()
      assert {:ok, %Follower{}} = Blog.delete_follower(follower)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_follower!(follower.id) end
    end

    test "change_follower/1 returns a follower changeset" do
      follower = follower_fixture()
      assert %Ecto.Changeset{} = Blog.change_follower(follower)
    end
  end

  describe "following" do
    alias Microblog.Blog.Following

    @valid_attrs %{email_me: "some email_me", email_owner: "some email_owner"}
    @update_attrs %{email_me: "some updated email_me", email_owner: "some updated email_owner"}
    @invalid_attrs %{email_me: nil, email_owner: nil}

    def following_fixture(attrs \\ %{}) do
      {:ok, following} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_following()

      following
    end

    test "list_following/0 returns all following" do
      following = following_fixture()
      assert Blog.list_following() == [following]
    end

    test "get_following!/1 returns the following with given id" do
      following = following_fixture()
      assert Blog.get_following!(following.id) == following
    end

    test "create_following/1 with valid data creates a following" do
      assert {:ok, %Following{} = following} = Blog.create_following(@valid_attrs)
      assert following.email_me == "some email_me"
      assert following.email_owner == "some email_owner"
    end

    test "create_following/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_following(@invalid_attrs)
    end

    test "update_following/2 with valid data updates the following" do
      following = following_fixture()
      assert {:ok, following} = Blog.update_following(following, @update_attrs)
      assert %Following{} = following
      assert following.email_me == "some updated email_me"
      assert following.email_owner == "some updated email_owner"
    end

    test "update_following/2 with invalid data returns error changeset" do
      following = following_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_following(following, @invalid_attrs)
      assert following == Blog.get_following!(following.id)
    end

    test "delete_following/1 deletes the following" do
      following = following_fixture()
      assert {:ok, %Following{}} = Blog.delete_following(following)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_following!(following.id) end
    end

    test "change_following/1 returns a following changeset" do
      following = following_fixture()
      assert %Ecto.Changeset{} = Blog.change_following(following)
    end
  end

  describe "follows" do
    alias Microblog.Blog.Follow

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def follow_fixture(attrs \\ %{}) do
      {:ok, follow} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_follow()

      follow
    end

    test "list_follows/0 returns all follows" do
      follow = follow_fixture()
      assert Blog.list_follows() == [follow]
    end

    test "get_follow!/1 returns the follow with given id" do
      follow = follow_fixture()
      assert Blog.get_follow!(follow.id) == follow
    end

    test "create_follow/1 with valid data creates a follow" do
      assert {:ok, %Follow{} = follow} = Blog.create_follow(@valid_attrs)
    end

    test "create_follow/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_follow(@invalid_attrs)
    end

    test "update_follow/2 with valid data updates the follow" do
      follow = follow_fixture()
      assert {:ok, follow} = Blog.update_follow(follow, @update_attrs)
      assert %Follow{} = follow
    end

    test "update_follow/2 with invalid data returns error changeset" do
      follow = follow_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_follow(follow, @invalid_attrs)
      assert follow == Blog.get_follow!(follow.id)
    end

    test "delete_follow/1 deletes the follow" do
      follow = follow_fixture()
      assert {:ok, %Follow{}} = Blog.delete_follow(follow)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_follow!(follow.id) end
    end

    test "change_follow/1 returns a follow changeset" do
      follow = follow_fixture()
      assert %Ecto.Changeset{} = Blog.change_follow(follow)
    end
  end

  describe "likes" do
    alias Microblog.Blog.Like

    @valid_attrs %{number: 42}
    @update_attrs %{number: 43}
    @invalid_attrs %{number: nil}

    def like_fixture(attrs \\ %{}) do
      {:ok, like} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_like()

      like
    end

    test "list_likes/0 returns all likes" do
      like = like_fixture()
      assert Blog.list_likes() == [like]
    end

    test "get_like!/1 returns the like with given id" do
      like = like_fixture()
      assert Blog.get_like!(like.id) == like
    end

    test "create_like/1 with valid data creates a like" do
      assert {:ok, %Like{} = like} = Blog.create_like(@valid_attrs)
      assert like.number == 42
    end

    test "create_like/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_like(@invalid_attrs)
    end

    test "update_like/2 with valid data updates the like" do
      like = like_fixture()
      assert {:ok, like} = Blog.update_like(like, @update_attrs)
      assert %Like{} = like
      assert like.number == 43
    end

    test "update_like/2 with invalid data returns error changeset" do
      like = like_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_like(like, @invalid_attrs)
      assert like == Blog.get_like!(like.id)
    end

    test "delete_like/1 deletes the like" do
      like = like_fixture()
      assert {:ok, %Like{}} = Blog.delete_like(like)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_like!(like.id) end
    end

    test "change_like/1 returns a like changeset" do
      like = like_fixture()
      assert %Ecto.Changeset{} = Blog.change_like(like)
    end
  end

  describe "tags" do
    alias Microblog.Blog.Tag

    @valid_attrs %{search: "some search"}
    @update_attrs %{search: "some updated search"}
    @invalid_attrs %{search: nil}

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_tag()

      tag
    end

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Blog.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Blog.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = Blog.create_tag(@valid_attrs)
      assert tag.search == "some search"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, tag} = Blog.update_tag(tag, @update_attrs)
      assert %Tag{} = tag
      assert tag.search == "some updated search"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_tag(tag, @invalid_attrs)
      assert tag == Blog.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Blog.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Blog.change_tag(tag)
    end
  end
end
