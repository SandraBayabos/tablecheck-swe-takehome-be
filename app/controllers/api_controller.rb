class ApiController < ActionController::API
  before_action :transform_params

  # Transform all request parameters to snake_case
  def transform_params
    request.parameters.deep_transform_keys!(&:underscore)
  end
end
