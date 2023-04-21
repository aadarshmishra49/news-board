require 'rails_helper'

RSpec.describe CategoriesController do
      
    let!(:count) {Category.all.count}
    let!(:category2) {create(:category)}

    describe 'GET index' do
        
        it "assigns category" do
            get :index
            expect(Category.all.count).to eq(count+1)
        end
  
    end

    describe "GET #show" do
    it "assigns the requested message to @message" do
      get :show, params: { id: category2.id }
      expect(assigns(:category)).to eq(category2)
    end
  end

    
    
   
end