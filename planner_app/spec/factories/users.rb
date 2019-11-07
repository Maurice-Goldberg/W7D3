FactoryBot.define do
    factory :user do 
        username { Faker::Name.first_name }
        password { "hunter2" }
        password_digest { BCrypt::Password.create("hunter2").to_s }
        session_token { "blahblahblahhhh" }
    end
end