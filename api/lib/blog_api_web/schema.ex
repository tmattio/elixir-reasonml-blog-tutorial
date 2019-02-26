defmodule BlogApiWeb.Schema do
  use Absinthe.Schema

  object :blog_post do
    field(:id, non_null(:id))
    field(:title, non_null(:string))
    field(:body, non_null(:string))
  end

object :user do
  field(:name, non_null(:string))
  field(:email, non_null(:string))
  field(:blog_posts, non_null(list_of(non_null(:blog_post))))
end

object :session do
  field(:token, non_null(:string))
  field(:user, non_null(:user))
end

  query do
    field :blog_posts, non_null(list_of(non_null(:blog_post))) do
      resolve(fn _args, _info ->
        {:ok, BlogApi.Repo.all(BlogApi.Blog.Post)}
      end)
    end

    field :blog_post, :blog_post do
      # The arg macro allows us to define arguments to our queries.
      # The map of arguments is passed to the resolve function.
      @desc "The primary ID of the blog post to fetch."
      arg(:id, non_null(:id))

      # When we write %{id: id}, we are pattern matching the arguments and put the value of
      # id in id.
      resolve(fn %{id: id}, _info ->
        {:ok, BlogApi.Repo.get(BlogApi.Blog.Post, id)}
      end)
    end
  end

  mutation do
    field :create_blog_post, type: :blog_post do
      arg(:title, non_null(:string))
      arg(:body, non_null(:string))

      resolve(fn
        %{title: title, body: body},
        %{context: %{current_user: _user = %BlogApi.Accounts.User{id: user_id}}} ->
          BlogApi.Blog.create_post(%{title: title, body: body, author_id: user_id})

        _args, _info ->
          {:error, "You need to authentify to create a blog post"}
      end)
    end

    field :user_login, type: :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(fn args, _info ->
        with {:ok, user} <- BlogApi.Accounts.UserAuth.authenticate(args),
             {:ok, jwt, _full_claims} <- BlogApiWeb.Auth.GuardianSerializer.encode_and_sign(user) do
          {:ok, %{token: jwt, user: user}}
        end
      end)
    end

    field :user_register, type: :session do
      arg(:email, non_null(:string))
      arg(:name, non_null(:string))
      arg(:password, non_null(:string))

      resolve(fn args, _info ->
        with {:ok, _} <- BlogApi.Accounts.create_user(args),
             {:ok, user} <- BlogApi.Accounts.UserAuth.authenticate(args),
             {:ok, jwt, _full_claims} <- BlogApiWeb.Auth.GuardianSerializer.encode_and_sign(user) do
          {:ok, %{token: jwt, user: user}}
        end
      end)
    end
  end
end
