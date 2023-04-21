require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
    let!(:count) {Message.all.count}

    let!(:author) { build(:author) }
    let(:category) { build(:category)}
    let!(:message1) { create(:message, author: author,category:category) }
  
    #rspec for get index
    describe "GET #index" do
        it "assigns messages to message" do
            get :index
            expect((Message).all.count).to eq(count+1)
        end
   end
   
    describe "GET #show" do
      it "assigns the requested message to @message" do
        get :show, params: { id: message1.id }
        expect(assigns(:message)).to eq(message1)
      end
    end
    #rspec for create action
    describe "POST #create" do 
        before(:each) do
            sign_in(author)
        end
        context "when author is signed in" do
        it "should creates a new message" do
        post :create, params: { message: { title: "jqygswufdywqfdnjjldskfv", description: "mhwqnmbnknkdfdjwq"} ,author_id:author.id,category_id:category.id}
        expect(Message.exists?(message1.id)).to be true

        end
      end
     #rspec invalid - params
      context "with invalid params" do
        it "should not create a new post" do
          expect {
            post :create, params: { message: { title: "", description: "" }, author_id: author.id, category_id: category.id }
          }.not_to change(Message, :count)
        end
      end
    
    end

    #rspec for destroy action
    describe "DELETE #destroy" do
        before(:each) do
            sign_in(author)
        end 
        it "destroys the post" do
            delete :destroy, params: { id: message1.id, message: { title: "Test Post", description: "This is a test post." },author_id: author.id, category_id: category.id }
            expect(Message.exists?(message1.id)).to be false
        end
    end
   
    #rspec for update action for message
    describe "PUT #update" do
        before(:each) do
            sign_in(author)
        end 
        context "with valid params" do
            it "updates the message" do
            put :update, params: { id: message1.id, message: { title: "Update" }, author_id: author.id,category_id: category.id}
            message1.reload
            expect(message1.title).to eq "Update" 
            end
        end

        context "with invalid params" do
          it "does not update the message" do
          put :update, params: { id: message1.id, message: { title: "" }, author_id: author.id,category_id: category.id }
          message1.reload
          expect(message1.title).not_to eq ""
          end
        end
    end



  
end


