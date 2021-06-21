defmodule TurleyDev.Timeline do
  require Logger
  alias Phoenix.PubSub
  alias TurleyDev.Repo
  alias TurleyDev.Timeline.Post
  import Ecto.Query

  def get_all do
    Post
    |> order_by(desc: :inserted_at)
    |> preload(:creator)
    |> Repo.all()
  end

  def create_text_post(creator, text) do
    %Post{}
    |> Post.changeset(%{content: text, creator_id: creator.id})
    |> Repo.insert()
    |> broadcast_added()
  end

  def subscribe do
    PubSub.subscribe(TurleyDev.PubSub, "timeline")
  end

  defp broadcast_added({:error, _r}), do: Logger.error("failed to add post")

  defp broadcast_added({:ok, post}) do
    PubSub.broadcast(TurleyDev.PubSub, "timeline", {:post_added, %{"post" => post}})

    {:ok, post}
  end
end
