require 'rails_helper'

RSpec.describe "SessionsControllers", type: :request do
  let!(:user) { FactoryBot.create(:user) }

  describe "GET /new" do
    it "should render the new" do
      get sign_in_path
      expect(response).to render_template('new')
    end
  end

  describe "POST /create" do
    it "should create the new session" do
      params = { email: user.email, password: user.password }
      post sign_in_path, params: params
      expect(response.status).to eq(302)
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to match('logged in successfully')
    end

    it "should not create the new session" do
      params = { email: user.email }
      post sign_in_path, params: params
      expect(response.status).to eq(422)
      expect(response).to render_template('new')
      expect(flash[:alert]).to match('Invalid Email or password')
    end
  end

  describe "DESTROY /delete" do
    it "should destroy the address" do
      delete logout_path
      expect(response.status).to eq(302)
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to match('Logged Out')
    end
  end
end
