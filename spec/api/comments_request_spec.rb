require 'rails_helper'

RSpec.describe "GET /api/v1/comments", type: :request do
  
  #for all comments 
  describe "GET /api/v1/comments" do
    context "when comments exist" do
      let!(:count) {Comment.all.count}

      let!(:author) { create(:author) }
      let!(:category) { create(:category) }
      let!(:message) { create(:message, author: author, category: category) }
      let!(:user) { create(:user)}
      let!(:comment) {create_list(:comment,3,user:user,message:message)}

      before(:each) do
        get "/api/v1/comments"
      end
      it "returns a successful response" do
        expect(response).to have_http_status(200)
      end
  

      it "returns a JSON response with all comments" do
        expect(JSON.parse(response.body).size).to eq(count+3)
      end
    end

    context "when no messages exist" do
      before(:each) do
        Comment.destroy_all
        get "/api/v1/comments"
      end

      it "returns an empty JSON response" do
        expect(response.body).to eq('[]')

      end
    end
  end

  #for show action in comments

  describe "GET /api/v1/comments/:id" do
    context "when the commment exists" do
      
    let!(:author) { create(:author) }
    let!(:category) { create(:category) }
    let!(:message) { create(:message, author: author, category: category) }
    let!(:user) { create(:user)}
    let!(:comment) {create(:comment,user:user,message:message)}

  
      before { get "/api/v1/comments/#{comment.id}" }
      
      it "returns a success response" do
        expect(response).to have_http_status(:success)
      end
      
      it "returns the comment in JSON format" do
        expect(response.body).to eq([comment].to_json)
      end
    end
    
    context "when the comment does not exist" do
      before { get "/api/v1/messages/999" }
      
      it "returns a 404 not found status" do
        expect(response).to have_http_status(:not_found)
      end
      
      it "returns an error message in JSON format" do
        expect(response.body).to eq({ message: "Record not found" }.to_json)
      end
    end

   end


    #for creating a comment through api 
    describe "POST create" do
        context "with valid attributes" do
        let!(:author) { create(:author) }
        let!(:category) { create(:category) }
        let!(:message) { create(:message, author: author, category: category) }
        let!(:user) { create(:user)}
        let!(:comment) {create(:comment,user:user,message:message)}
        let(:valid_attributes) { { comment: { content: "Test Comment", message_id: message.id, user_id: user.id } } }

        it "creates a new message" do
            expect {
            post "/api/v1/comments", params: valid_attributes
            }.to change(Comment, :count).by(1)
        end
    
        it "returns a successful response" do
            post "/api/v1/comments", params: valid_attributes
            expect(response).to have_http_status(:created)
        end
    
        it "returns the created message in the response" do
            post "/api/v1/comments", params: valid_attributes
            expect(JSON.parse(response.body)["content"]).to eq("Test Comment")
        end
        end
    
        context "with invalid attributes" do
        let(:invalid_attributes) { { comment: { content: nil} } }
    
        it "does not create a new comment" do
            expect {
            post "/api/v1/comments", params: invalid_attributes
            }.to_not change(Comment, :count)
        end
    
        it "returns an error message in the response" do
            post "/api/v1/comments", params: invalid_attributes
            expect(JSON.parse(response.body)["error"]).to_not be_empty
        end
    
        it "returns a 422 unprocessable entity status code" do
            post "/api/v1/comments", params: invalid_attributes
            expect(response).to have_http_status(:unprocessable_entity)
        end
        end



    end
    
    #for updating the comment
    describe "PUT #update" do
      context "with valid params" do
        let!(:author) { create(:author) }
        let!(:category) { create(:category) }
        let!(:message) { create(:message, author: author, category: category) }
        let!(:user) { create(:user)}
        let!(:comment) {create(:comment,user:user,message:message)}
        

        let(:updated_attributes) { { content: "New Comment" } }
  
        before(:each) do
          put api_v1_comment_path(comment.id), params: { comment: updated_attributes }
        end
  
        it "returns a successful response" do
          expect(response).to have_http_status(:ok)
        end
  
        it "updates the message" do
          expect(comment.reload.content).to eq(updated_attributes[:content])
        end
      end
      
      context "when the comment does not exist" do
        before(:each) do
          put api_v1_comment_path(0), params: { comment: { content: "New Content" } }
        end
  
        it "returns a 404 response" do
          expect(response).to have_http_status(:unprocessable_entity)
        end
  
        it "returns an error message" do
          expect(JSON.parse(response.body)["message"]).to eq("Record not found")
        end
      end
    end

    # for destroy action 
    describe "DELETE /api/v1/comments/:id" do
       
        let!(:author) { create(:author) }
        let!(:category) { create(:category) }
        let!(:message) { create(:message, author: author, category: category) }
        let!(:user) { create(:user)}
        let!(:comment) {create(:comment,user:user,message:message)}
        

        it "deletes the message" do
          expect {
            delete api_v1_comment_path(comment.id)
          }.to change(Comment, :count).by(-1)
        end
    
        it "returns a successful response" do
          delete api_v1_comment_path(comment.id)
          expect(response).to have_http_status(:ok)
        end
    
        it "returns a 'Deleted' message" do
          delete api_v1_comment_path(comment.id)
          expect(JSON.parse(response.body)).to eq({ "comment" => "Deleted" })
        end
    
      end

  
    

  

end
