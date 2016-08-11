require 'rails_helper'

RSpec.describe "Voluntaries", type: :request do
  describe "GET /voluntaries" do
    it "works! (now write some real specs)" do
      get voluntaries_path
      expect(response).to have_http_status(200)
    end
  end
end
