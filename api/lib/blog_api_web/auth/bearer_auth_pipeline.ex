defmodule BlogApiWeb.Auth.BearerAuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :blog_api,
    module: BlogApiWeb.Auth.GuardianSerializer,
    error_handler: BlogApiWeb.Auth.ErrorHandler

  plug(Guardian.Plug.VerifyHeader, realm: "Bearer")
  plug(Guardian.Plug.LoadResource, allow_blank: true)
end
