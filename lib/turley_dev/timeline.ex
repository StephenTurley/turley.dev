defmodule TurleyDev.Timeline do
  require Logger
  alias Phoenix.PubSub
  alias TurleyDev.Repo
  alias TurleyDev.Timeline.Post
  alias TurleyDev.Timeline.Comment
  import Ecto.Query

  def get_all do
    Post
    |> order_by(desc: :inserted_at)
    |> preload(:creator)
    |> preload(:comments)
    |> Repo.all()
  end

  def create_text_post(creator, text) do
    %Post{}
    |> Post.changeset(%{content: text, creator_id: creator.id})
    |> Repo.insert()
    |> post_added()
  end

  def create_comment(user, post_id, content) do
    %Comment{}
    |> Comment.changeset(%{user_id: user.id, post_id: post_id, content: content})
    |> Repo.insert()
  end

  def subscribe do
    PubSub.subscribe(TurleyDev.PubSub, "timeline")
  end

  defp post_added({:error, _r}), do: Logger.error("failed to add post")

  defp post_added({:ok, post}) do
    PubSub.broadcast(TurleyDev.PubSub, "timeline", {:post_added, %{"post" => post}})
    {:ok, post}
  end
end
