require 'rails_helper'

RSpec.describe User, type: :model do


  describe '#new' do
   
    context 'when user is present' do
      let(:user1) {create :user}
      let(:user2) {build :user,email: "email"}
      

      it 'should check for validity' do
        #byebug
        expect(user1.valid?).to eq(true)
      end
      
      it 'should not be valid user, without valid email' do
        expect(user2.valid?).to eq(false)
      end

    end
  end

end
