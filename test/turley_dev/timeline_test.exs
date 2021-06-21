defmodule TurleyDev.TimelineTest do
  use TurleyDev.DataCase

  alias TurleyDev.Timeline.Post
  alias TurleyDev.Timeline

  describe "create_text_post/1" do
    test "it creates the post" do
      {:ok, %Post{content: content}} = Timeline.create_text_post("Flerpn derpn")
      assert content == "Flerpn derpn"
    end

    test "it broadcasts post_added" do
      Timeline.subscribe()

      {:ok, post} = Timeline.create_text_post("Flerpn derpn")

      assert_receive {:post_added, %{"post" => result}}
      assert result == post
    end
  end

  describe "get_all/0" do
    test "it will return an empty list" do
      assert Timeline.get_all() == []
    end

    test "it will return all the posts" do
      Timeline.create_text_post("First")
      Timeline.create_text_post("Second")
      Timeline.create_text_post("Third")

      result =
        Timeline.get_all()
        |> Enum.map(& &1.content)

      assert result == ["First", "Second", "Third"]
    end
  end
end
