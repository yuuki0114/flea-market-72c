require 'rails_helper'

describe ItemsController do
  describe 'GET #search' do
    it "@itemsは期待した値になること？" do
      @items = [create(:item)]
      get :search, params: { name: @items[0] }
      expect(assigns(:items)).to eq @items 
    end

    it "search.html.hamlに遷移すること" do
      get :search
      expect(response).to render_template :search
    end
  end
end