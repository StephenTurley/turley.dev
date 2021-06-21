defmodule TurleyDevWeb.PageLive do
  use TurleyDevWeb, :live_view
  alias TurleyDev.Timeline

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Timeline.subscribe()
    posts = Timeline.get_all()
    {:ok, assign(socket, typing: false, content: "", posts: posts)}
  end

  @impl true
  def handle_event("create_post", %{"content" => content}, socket) do
    Timeline.create_text_post(content)

    {:noreply, assign(socket, content: "", posts: Timeline.get_all())}
  end

  @impl true
  def handle_info({:post_added, %{"post" => _post}}, socket) do
    {:noreply, assign(socket, posts: Timeline.get_all())}
  end
end
