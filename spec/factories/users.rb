FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }

    after(:create) do |user|
      user.update(token: generate_token_for_factory(user))
    end
  end
end

def generate_token_for_factory(user)
  payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
  JWT.encode(payload, Rails.application.credentials.secret_key_base)
end
