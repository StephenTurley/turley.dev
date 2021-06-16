defmodule TurleyDevWeb.PageLive do
  use TurleyDevWeb, :live_view
  alias TurleyDev.Repo
  alias TurleyDev.Post

  @impl true
  def mount(_params, _session, socket) do
    posts = Repo.all(Post)
    {:ok, assign(socket, typing: false, msg: "", posts: posts)}
  end

  @impl true
  def handle_event("send_message", %{"msg" => msg}, socket) do
    IO.inspect(socket)

    Post.changeset(%Post{}, %{content: msg})
    |> Repo.insert

    {:noreply, assign(socket, msg: "", posts: Repo.all(Post))}
  end
end
