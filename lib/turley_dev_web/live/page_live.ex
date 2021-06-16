defmodule TurleyDevWeb.PageLive do
  use TurleyDevWeb, :live_view
  alias TurleyDev.Repo
  alias TurleyDev.Post
  alias Phoenix.PubSub

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: subscribe()
    posts = Repo.all(Post)
    {:ok, assign(socket, typing: false, msg: "", posts: posts)}
  end

  @impl true
  def handle_event("send_message", %{"msg" => msg}, socket) do
    Post.changeset(%Post{}, %{content: msg})
    |> Repo.insert
    |> broadcast

    {:noreply, assign(socket, msg: "", posts: Repo.all(Post))}
  end

  @impl true
  def handle_info({:post_added, %{"post" => post}}, socket) do
    {:noreply, assign(socket, posts: Repo.all(Post))}
  end

  defp subscribe() do
    PubSub.subscribe(TurleyDev.PubSub, "posts")
  end

  defp broadcast({:error, _r}), do: IO.puts('error')

  defp broadcast({:ok, post}) do
    PubSub.broadcast(TurleyDev.PubSub, "posts", {:post_added, %{"post" => post}})
  end
end
