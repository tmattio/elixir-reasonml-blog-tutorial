defmodule BlogApiWeb.Router do
  use BlogApiWeb, :router

pipeline :api do
  plug(CORSPlug)
  plug(BlogApiWeb.Auth.BearerAuthPipeline)
  plug(BlogApiWeb.Plugs.GraphQLContext)
end

scope "/api" do
  pipe_through([:api])
  forward("/", Absinthe.Plug, schema: BlogApiWeb.Schema, json_codec: Jason)
end

forward("/", Absinthe.Plug.GraphiQL, schema: BlogApiWeb.Schema, json_codec: Jason)
end
