require 'rails_helper'
RSpec.describe CommentsController, type: :controller do
    let!(:user) { create(:user) }
    let!(:author) { create(:author) }
    let!(:category) { create(:category) }
    let(:message1) { create(:message, author: author,category:category) }

    let(:comm1) { create(:comment, user: user, message:message1) }
    let(:comm2) { create(:comment, user: user, message:message1) }
    describe "POST #create" do 
        before(:each) do
            sign_in(user)
        end
        context "when user is signed in" do
            it "creates comment on post" do
            post :create, params: { comment: { content: "jqygswufdywqfd"} ,message_id:message1.id,user_id:user.id}
            expect(Comment.exists?(comm1.id)).to be true
            end
        end
    

        context "with invalid params" do
            it "does not create comment" do
            expect {
                post :create, params: { comment: { content: "" }, message_id:message1.id ,user_id:user.id }
            }.not_to change(Comment, :count)
            end
        end
    end

    

    describe "PUT #update" do
        before(:each) do
            sign_in(user)
        end 
        context "with valid params" do
            it "updates the comment" do
            put :update, params: { id: comm1.id, comment: { content: "Update" }, message_id: message1.id, user_id: user.id }
            comm1.reload
            expect(comm1.content).to eq "Update" 
            end
        end
    end 

    describe "DELETE #destroy" do
        before(:each) do
        sign_in(user)
        end 
        it "destroys the comment" do
        delete :destroy, params: { id: comm1.id, message_id: message1.id, user_id: user.id }
        expect(Comment.exists?(comm1.id)).to be false
        end
    end





  
end


