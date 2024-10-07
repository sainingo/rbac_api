class ApplicationController < ActionController::API
    include JsonWebToken
  
    before_action :authenticate_request
    
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from ActionController::ParameterMissing, with: :bad_request
  
    private
  
    def authenticate_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      decoded = jwt_decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  
    def authorize_request(permission)
      unless @current_user.role.permissions.exists?(name: permission)
        render json: { error: 'Unauthorized' }, status: :forbidden
      end
    end
  
    def not_found(exception)
      render json: { error: exception.message }, status: :not_found
    end
  
    def unprocessable_entity(exception)
      render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
  
    def bad_request(exception)
      render json: { error: exception.message }, status: :bad_request
    end
  end