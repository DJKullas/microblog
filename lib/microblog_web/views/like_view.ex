defmodule MicroblogWeb.LikeView do
  use MicroblogWeb, :view
  alias MicroblogWeb.LikeView

  def render("index.json", %{likes: likes}) do
    %{data: render_many(likes, LikeView, "like.json")}
  end

  def render("show.json", %{like: like}) do
    %{data: render_one(like, LikeView, "like.json")}
  end

  def render("like.json", %{like: like}) do
    data = %{
      id: like.id,
      number: like.number
    }

    if Ecto.assoc_loaded?(like.post) do
      Map.put(data, :likes, like.number)
    else
      data
    end
  end
end
