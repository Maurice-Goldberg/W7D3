require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    subject(:user) { FactoryBot.create(:user) }

    describe "GET #show" do
        it "renders the show template" do 
            get :show, id: user.id
            expect(response).to render_template(:show)
        end

        context "if user does not exist" do 
            it "is not a success" do
                begin
                    get :show, id: -1
                rescue => exception
                    ActiveRecord::RecordNotFound
                end

                expect(response).not_to render_template(:show)
            end
        end
    end

    describe "GET #new" do
        it "renders the new template" do
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe "POST #create" do 
        context "with invalid params" do 
            it "renders the new template" do 
                post :create, user1: { username: "jason" }
                expect(response).to render_template(:new)
            end
        end

        context "with valid params" do
            it "redirects to user page on success" do
                post :create, :user
                expect(response).to redirect_to(user_url(:user))
            end
        end
    end
end