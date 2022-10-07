require 'rails_helper'

RSpec.describe "WelcomeControllers", type: :request do
  describe "GET /root" do
    it "renders the index template" do
      get root_path
      expect(response).to render_template('index')
    end
  end
end
