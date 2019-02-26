defmodule BlogApi.Accounts.UserAuth do
  alias BlogApi.Accounts.User

  @doc """
  Return the user if the authentication parameters are valid (the password matches).
  If the parameters are invalid, return an error.
  """
  @spec authenticate(%{email: String.t(), password: String.t()}) ::
          {:ok, User} | {:error, String.t()}
  def authenticate(params) do
    user = BlogApi.Repo.get_by(User, email: params.email)

    case check_password(user, params.password) do
      true -> {:ok, user}
      _ -> {:error, "Incorrect login credentials"}
    end
  end

  def hash_password(password), do: Comeonin.Bcrypt.hashpwsalt(password)

  @spec check_password(User, String.t()) :: boolean
  defp check_password(user, password) do
    case user do
      nil -> false
      _ -> Comeonin.Bcrypt.checkpw(password, user.password_hash)
    end
  end
end
