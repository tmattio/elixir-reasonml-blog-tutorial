defmodule BlogApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field(:email, :string)
    field(:name, :string)
    field(:password_hash, :string)
    field(:password, :string, virtual: true)

    timestamps()
  end

  @required_fields ~w(email name)a

  @doc false
  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ [:password])
    |> validate_required(@required_fields ++ [:password])
    |> unique_constraint(:email)
    |> validate_length(:password, min: 6)
    |> put_pass_hash()
  end

  @doc false
  def update_changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ [:password])
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 6)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, BlogApi.Accounts.UserAuth.hash_password(pass))

      _ ->
        changeset
    end
  end
end
