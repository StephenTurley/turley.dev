defmodule TurleyDev.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    belongs_to :creator, TurleyDev.Accounts.User
    has_many :comments, TurleyDev.Timeline.Comment
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:content, :creator_id])
    |> validate_required([:content])
    |> validate_required([:creator_id])
  end
end
