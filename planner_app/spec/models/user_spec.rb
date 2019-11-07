require 'rails_helper'

RSpec.describe User, type: :model do
    subject(:user) { User.create!(username: 'mauriceg123', password: "hunter12")}

    describe "validations" do
        it {should validate_presence_of(:username) }
        it {should validate_uniqueness_of(:username) }
        it {should validate_presence_of(:password_digest)}
        it {should validate_presence_of(:session_token)}
        it {should validate_uniqueness_of(:session_token)}
        it {should validate_presence_of(:password)}
    end

    describe "have associations" do
        it {should have_many(:goals)}
        it {should have_many(:authored_comments)}
    end

    describe "class methods" do
        describe "::find_by_credentials" do
            it "should return the user with the matching credentials" do
                # debugger
                expect(User.find_by_credentials(user.username, user.password)).to eq(user)
            end
        end
    end
end