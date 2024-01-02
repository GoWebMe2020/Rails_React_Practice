require "rails_helper"

RSpec.describe "Registrations", type: :request do
  describe "POST /users" do
    it "registers a new user" do
      expect {
        post user_registration_path, params: {
          user: {
            email: "test@example.com",
            password: "password",
            password_confirmation: "password"
          }
        }
      }.to change(User, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(response.body).to include("token")
    end

    it "does not registers a new user with an invalid email" do
      expect {
        post user_registration_path, params: {
          user: {
            email: "invalid email",
            password: "password",
            password_confirmation: "password"
          }
        }
      }.not_to change(User, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("error")
      expect(response.body).to include("Email is invalid")
    end

    it "does not registers a new user if the passwords do not match" do
      expect {
        post user_registration_path, params: {
          user: {
            email: "test@example.com",
            password: "password",
            password_confirmation: "incorrect_password"
          }
        }
      }.not_to change(User, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("error")
      expect(response.body).to include("Password confirmation doesn't match Password")
    end

    it "does not registers a new user if the password is not long enough" do
      expect {
        post user_registration_path, params: {
          user: {
            email: "test@example.com",
            password: "12345",
            password_confirmation: "12345"
          }
        }
      }.not_to change(User, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("error")
      expect(response.body).to include("Password is too short (minimum is 6 characters)")
    end

    it "does not registers a new user if the email already exists" do
      user = create(:user)

      expect {
        post user_registration_path, params: {
          user: {
            email: user.email,
            password: "password",
            password_confirmation: "password"
          }
        }
      }.not_to change(User, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("error")
      expect(response.body).to include("Email has already been taken")
    end
  end
end
