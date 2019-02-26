defmodule BlogApiWeb.Auth.GuardianSerializer do
  use Guardian, otp_app: :blog_api

  alias BlogApi.{Repo, Accounts.User}

  def subject_for_token(user = %User{}, _claims), do: {:ok, to_string(user.id)}
  def subject_for_token(_, _), do: {:error, "Unknown resource type"}

  def resource_from_claims(%{"sub" => user_id}), do: {:ok, Repo.get(User, user_id)}
  def resource_from_claims(_claims), do: {:error, "Unknown resource type"}
end
