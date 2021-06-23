defmodule TurleyDev.Timeline.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :content, :string
    belongs_to :user, TurleyDev.Accounts.User
    belongs_to :post, TurleyDev.Timeline.Post
    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content, :post_id, :user_id])
    |> validate_required([:content])
    |> validate_required([:post_id])
    |> validate_required([:user_id])
  end
end
