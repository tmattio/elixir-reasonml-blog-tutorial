defmodule BlogApisWeb.Schemas.BlogSchemaTest do
  use BlogApiWeb.ConnCase, async: true

  @query """
  query {
    blogPosts {
      id
      title
    }
  }
  """
  test "viewer can list all the posts" do
    {:ok, author} =
      BlogApi.Accounts.create_user(%{
        name: "Test User",
        email: "test@test.test",
        password: "password"
      })

    {:ok, blog_post} =
      BlogApi.Blog.create_post(%{title: "Hello World!", body: "Nothing :)", author_id: author.id})

    response = post(build_conn(), "/api", %{query: @query})
    assert json_response(response, 200)["errors"] == nil

    assert json_response(response, 200)["data"]["blogPosts"] == [
             %{
               "id" => blog_post.id,
               "title" => blog_post.title
             }
           ]
  end

  @query """
  query($id: ID!) {
    blogPost(id: $id) {
      title
    }
  }
  """
  test "viewer can query a blog post by ID" do
    {:ok, author} =
      BlogApi.Accounts.create_user(%{
        name: "Test User",
        email: "test@test.test",
        password: "password"
      })

    {:ok, blog_post} =
      BlogApi.Blog.create_post(%{title: "Hello World!", body: "Nothing :)", author_id: author.id})

    # Note how we pass the ID as a variable to the query.
    response = post(build_conn(), "/api", %{query: @query, variables: %{"id" => blog_post.id}})
    assert json_response(response, 200)["errors"] == nil

    assert json_response(response, 200)["data"]["blogPost"] == %{
             "title" => blog_post.title
           }
  end

  @query """
  mutation($title: String!, $body: String!) {
    createBlogPost(title: $title, body: $body) {
      title
      body
    }
  }
  """
  test "viewer can create a blog post" do
    {:ok, author} =
      BlogApi.Accounts.create_user(%{
        name: "Test User",
        email: "test@test.test",
        password: "password"
      })

    {:ok, jwt, _full_claims} = BlogApiWeb.Auth.GuardianSerializer.encode_and_sign(author)

    conn = build_conn()

    response =
      post(conn, "/api", %{
        query: @query,
        variables: %{"title" => "Hello World!", "body" => "Nothing :)"}
      })

    assert json_response(response, 200)["errors"] == nil

    assert json_response(response, 200)["data"]["createBlogPost"] == %{
             "title" => "Hello World!",
             "body" => "Nothing :)"
           }
  end
end
