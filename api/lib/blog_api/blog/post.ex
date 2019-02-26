defmodule BlogApi.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "posts" do
    field(:body, :string)
    field(:title, :string)

    belongs_to(:author, BlogApi.Accounts.User)

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:body, :title, :author_id])
    |> validate_required([:body, :title, :author_id])
    |> assoc_constraint(:author)
  end
end
