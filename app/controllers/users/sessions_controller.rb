class Users::SessionsController < Devise::SessionsController
  include TokenGeneration
  before_action :configure_sign_in_params, only: [:create]
  respond_to :json

  def create
    super do |user|
      if user.persisted?
        user.update(token: generate_token(user))
        render_successful_json_response(user) and return
      end
    end
  end

  def destroy
    begin
      token = extract_token_from_auth_header
      decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
      user_id = decoded_token["user_id"]
      user = User.find_by(id: user_id)

      if user
        user.update(token: nil)
        head :no_content
      else
        head :unauthorized
      end
    rescue JWT::DecodeError
      head :unauthorized
    end
  end

  private

  def render_successful_json_response(user)
    render json: { user: user, token: user.token }, status: :created
  end

  def extract_token_from_auth_header
    request.headers["Authorization"].to_s.split(" ").last
  end

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end

  def verify_signed_out_user
    if all_signed_out?
      set_flash_message! :notice, :already_signed_out
    else
      yield if block_given?
    end
  end

  protected

  def set_flash_message!(key, kind, options = {})

  end
end
