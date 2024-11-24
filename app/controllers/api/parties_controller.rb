class Api::PartiesController < ApiController
  before_action :authenticate_party, only: %i[check_in]

  def create
    @party = Party.new(party_params)
    if @party.save
      session[:party_id] = @party.id
      render json: @party, status: :created
    else
      render json: @party.errors.full_messages.join(', '), status: :unprocessable_entity
    end
  end

  def check_in
    if @current_party.seated? || @current_party.finished?
      return render json: { error: 'You have already checked in' }, status: :unprocessable_entity
    end
    
    unless @current_party.pending_check_in?
      return render json: { error: 'You are not allowed to check in yet' }, status: :unprocessable_entity
    end

    @current_party.update(status: 'seated')

    render json: @current_party, status: :ok
  end

  private

  def party_params
    params.permit(:name, :size)
  end
end
