require 'rails_helper'

RSpec.describe UsersController do
    describe 'GET index' do
        let!(:count) {User.all.count}
        let!(:user1) {create(:user)}
        
        it "assigns user" do
            get :index
            expect(User.all.count).to eq(count+1)
        end
    end
    
    
   
end