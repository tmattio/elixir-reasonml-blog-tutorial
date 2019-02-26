defmodule BlogApiWeb.Plugs.GraphQLContext do
  @behaviour Plug

  @type t :: %{context: map()}

  alias BlogApi.Accounts.User

  def init(opts), do: opts

  def call(conn, _) do
    case Guardian.Plug.current_resource(conn) do
      nil ->
        conn

      user = %User{} ->
        Absinthe.Plug.put_options(
          conn,
          context: %{current_user: user, conn: conn}
        )
    end
  end
end
