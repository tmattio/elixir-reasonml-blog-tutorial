defmodule BlogApi.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:body, :text)
      add(:title, :string)
      add(:author_id, references(:users, on_delete: :delete_all, type: :uuid))

      timestamps()
    end
  end
end
