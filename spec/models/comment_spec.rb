require 'rails_helper'

RSpec.describe Comment, type: :model do

    

    describe "comment-validations" do
    
        let(:message) {build :message}
        let(:user) { build(:user) }
        let(:comment) {build(:comment,message: message, user: user)}
        it "is valid with all attributes" do  
          expect(comment).to be_valid
        end
      end

end
