require "rails_helper"

RSpec.describe "Sessions", type: :request do
  let!(:user) { create(:user) }

  describe "POST /users/sign_in" do
    it "signs in the user" do
      post user_session_path, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }

      expect(response).to have_http_status(:created)
      expect(response.body).to include("token")
    end

    it "does not signs in the user if the password is incorrect" do
      post user_session_path, params: {
        user: {
          email: user.email,
          password: "invalid password"
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "does not signs in the user if the password is incorrect" do
      post user_session_path, params: {
        user: {
          email: "incorrect_email@mail.com",
          password: user.password
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /users/sign_out" do
    before do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      token = JSON.parse(response.body)["token"]
      @headers = { "Authorization": "Bearer #{token}" }
    end

    it "signs out the user" do
      delete destroy_user_session_path, headers: @headers

      expect(response).to have_http_status(:no_content)
    end
  end
end
