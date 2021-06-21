defmodule TurleyDev.Timeline do
  require Logger
  alias Phoenix.PubSub
  alias TurleyDev.Repo
  alias TurleyDev.Timeline.Post

  def get_all do
    Repo.all(Post)
  end

  def create_text_post(text) do
    %Post{}
    |> Post.changeset(%{content: text})
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
