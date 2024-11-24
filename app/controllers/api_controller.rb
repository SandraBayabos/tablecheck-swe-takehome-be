class ApiController < ActionController::API
  before_action :transform_params

  # Transform all request parameters to snake_case
  def transform_params
    request.parameters.deep_transform_keys!(&:underscore)
  end

  # get current_party from session[:party_id]
  def authenticate_party
    @current_party = Party.find_by(id: session[:party_id])
    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_party
  end
end
