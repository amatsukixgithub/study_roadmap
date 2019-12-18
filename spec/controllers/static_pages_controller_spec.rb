require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe '#home' do
    it "正常なレスポンスを返す" do
      get :home
      expect(response).to be_successful
    end

    it "200レスポンスを返す" do
      get :home
      expect(response).to have_http_status "200"
    end
  end
end
