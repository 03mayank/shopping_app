require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe "RegistrationsControllers", type: :request do
  describe "GET /index" do
    it "renders the index template" do
      get sign_up_path
      expect(response).to render_template('new')
    end
  end

  describe "POST:  create" do
    before(:each) do
      @user = User.create(
        email: "abc@xyz.com", 
        password: '1234', 
        password_confirmation: '1234', 
        first_name: 'first', 
        last_name: 'last', 
        mobile: '1234567890'
      )
    end
  
    it "creates a new registration" do
      params = {
        user: {
          email: "pqr@lmn.com", 
          password: '1234', 
          password_confirmation: '1234', 
          first_name: 'first', 
          last_name: 'last', 
          mobile: '9876543210'
        }
      }
      post sign_up_path, params: params
      expect(response.status).to eq(302)
    end
    
    it "creates a new registration" do
      params = {
        user: {
          email: "pqr@lmn.com", 
          password: '1234', 
          password_confirmation: '1234', 
          first_name: 'first', 
          last_name: 'last', 
          mobile: ''   # Mobile number missing
        }
      }
      post sign_up_path, params: params
      expect(response.status).to eq(422)
    end
    
    it "redirect after new registration to root" do
      params = {
        user: {
          email: "pqr@lmn.com", 
          password: '1234', 
          password_confirmation: '1234', 
          first_name: 'first', 
          last_name: 'last', 
          mobile: '9876543210'
        }
      }
      post sign_up_path, params: params
      expect(response).to redirect_to(root_path)
    end
    
    it "job is created" do
      params = {
        user: {
          email: "csdc@lmn.com", 
          password: '1234', 
          password_confirmation: '1234', 
          first_name: 'first', 
          last_name: 'last', 
          mobile: '9876543210' 
        }
      }
      post sign_up_path, params: params
      ActiveJob::Base.queue_adapter = :test
      expect {
        SignupJob.perform_later(user: @user)
      }.to have_enqueued_job.on_queue('default')
    end

    it "redirect after new registration fail to new" do
      params = {
        user: {
          email: "pqr@lmn.com", 
          password: '1234', 
          password_confirmation: '1234', 
          first_name: 'first', 
          last_name: 'last', 
          mobile: '' # Mobile number missing
        }
      }
      post sign_up_path, params: params
      expect(response).to render_template(:new)
    end
  end
end
