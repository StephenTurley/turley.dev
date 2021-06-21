defmodule TurleyDev.Repo.Migrations.AddCreatorToPosts do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add(:creator_id, references(:users))
    end
  end
end
