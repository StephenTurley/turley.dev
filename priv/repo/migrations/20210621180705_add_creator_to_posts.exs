defmodule TurleyDev.Repo.Migrations.AddCreatorToPosts do
  use Ecto.Migration
  alias TurleyDev.Repo
  alias TurleyDev.Timeline.Post

  def change do
    Repo.delete_all(Post)

    alter table("posts") do
      add(:creator_id, references(:users))
    end
  end
end
