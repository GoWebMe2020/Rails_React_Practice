class Users::RegistrationsController < Devise::RegistrationsController
  include TokenGeneration
  respond_to :json

  def create
    super do |user|
      if user.persisted?
        user.update(token: generate_token(user))
        render_successful_json_response(user) and return
      else
        render_unsuccessful_json_response(user) and return
      end
    end
  end

  private

  def render_successful_json_response(user)
    render json: { user: user, token: user.token }, status: :created
  end

  def render_unsuccessful_json_response(user)
    render json: { error: user.errors.full_messages }, status: :unprocessable_entity
  end
end
