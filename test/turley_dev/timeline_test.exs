defmodule TurleyDev.TimelineTest do
  use TurleyDev.DataCase
  import TurleyDev.AccountsFixtures

  alias TurleyDev.Timeline.Post
  alias TurleyDev.Timeline

  describe "create_text_post/2" do
    test "it creates the post" do
      user = user_fixture()

      {:ok, %Post{content: content, creator_id: creator}} =
        Timeline.create_text_post(user, "Flerpn derpn")

      assert content == "Flerpn derpn"
      assert user.id == creator
    end

    test "it broadcasts post_added" do
      Timeline.subscribe()

      user = user_fixture()
      {:ok, post} = Timeline.create_text_post(user, "Flerpn derpn")

      assert_receive {:post_added, %{"post" => result}}
      assert result == post
    end
  end

  describe "get_all/0" do
    test "it will return an empty list" do
      assert Timeline.get_all() == []
    end

    test "it will preload the creator" do
      user = user_fixture()

      Timeline.create_text_post(user, "First")

      creator =
        Timeline.get_all()
        |> Enum.at(0)
        |> Map.get(:creator)

      assert creator == user
    end

    test "it will return all the posts in reverse order" do
      user = user_fixture()
      Timeline.create_text_post(user, "First")
      # TODO figure out how to stub out timestamps
      Process.sleep(1000)
      Timeline.create_text_post(user, "Second")
      # TODO figure out how to stub out timestamps
      Process.sleep(1000)
      Timeline.create_text_post(user, "Third")

      result =
        Timeline.get_all()
        |> Enum.map(& &1.content)

      assert result == ["Third", "Second", "First"]
    end
  end
end
