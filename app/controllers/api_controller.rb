class ApiController < ActionController::API
  before_action :transform_params

  # Transform all request parameters to snake_case
  def transform_params
    request.parameters.deep_transform_keys!(&:underscore)
  end

  # get current_party from session[:party_id]
  def authenticate_party
    @current_party = Party.find_by(id: session[:party_id])
    cookie_expiry = session[:expires_at]

    if @current_party.nil?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    elsif cookie_expiry.nil? || cookie_expiry < Time.zone.now
      session[:party_id] = nil
      render json: { error: 'Session expired' }, status: :unauthorized
    end
  end
end
