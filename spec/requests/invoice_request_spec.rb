require 'rails_helper'

RSpec.describe "Invoices", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/invoice/create"
      expect(response).to have_http_status(:success)
    end
  end

end