require 'rails_helper'

RSpec.describe "GET /api/v1/messages", type: :request do
  
  #for all messages 
  describe "GET /api/v1/messages" do
    context "when messages exist" do
      let!(:count) {Message.all.count}
      let!(:author) { create(:author) }
      let!(:category) { create(:category) }
      let!(:messages) { create_list(:message, 3, author: author, category: category) }

      before(:each) do
        get "/api/v1/messages"
      end
      it "returns a successful response" do
        expect(response).to have_http_status(200)
      end
  

      it "returns a JSON response with all messages" do
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(count+3)
      end
    end

    context "when no messages exist" do
      before(:each) do
        Message.destroy_all
        get "/api/v1/messages"
      end

      it "returns an empty JSON response" do
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to be_empty
      end
    end
  end

  #for show message with id 
  describe "GET /api/v1/messages/:id" do
    context "when the message exists" do
      let!(:author) { create(:author) }
      let!(:category) { create(:category) }
      let!(:message) { create(:message, author: author, category: category) }
      
      before { get "/api/v1/messages/#{message.id}" }
      
      it "returns a success response" do
        expect(response).to have_http_status(:success)
      end
      
      it "returns the author of the message in JSON format" do
        expect(response.body).to eq(author.to_json)
      end
    end
    
    context "when the message does not exist" do
      before { get "/api/v1/messages/999" }
      
      it "returns a 404 not found status" do
        expect(response).to have_http_status(:not_found)
      end
      
      it "returns an error message in JSON format" do
        expect(response.body).to eq({ message: "Record not found" }.to_json)
      end
    end
  end

  #for creating a message through api 
  describe "POST create" do
    context "with valid attributes" do
      let(:author) { create(:author) }
      let(:category) { create(:category) }
      let(:valid_attributes) { { message: { title: "Test Title", description: "Test Description", author_id: author.id, category_id: category.id } } }
  
      it "creates a new message" do
        expect {
          post "/api/v1/messages", params: valid_attributes
        }.to change(Message, :count).by(1)
      end
  
      it "returns a successful response" do
        post "/api/v1/messages", params: valid_attributes
        expect(response).to have_http_status(:created)
      end
  
      it "returns the created message in the response" do
        post "/api/v1/messages", params: valid_attributes
        expect(JSON.parse(response.body)["title"]).to eq("Test Title")
        expect(JSON.parse(response.body)["description"]).to eq("Test Description")
      end
    end
  
    context "with invalid attributes" do
      let(:invalid_attributes) { { message: { title: nil, description: nil } } }
  
      it "does not create a new message" do
        expect {
          post "/api/v1/messages", params: invalid_attributes
        }.to_not change(Message, :count)
      end
  
      it "returns an error message in the response" do
        post "/api/v1/messages", params: invalid_attributes
        expect(JSON.parse(response.body)["error"]).to_not be_empty
      end
  
      it "returns a 422 unprocessable entity status code" do
        post "/api/v1/messages", params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  #for updating the message 
  describe "PUT #update" do
  context "with valid params" do
    let(:author) { create(:author) }
    let(:category) { create(:category) }
  
    let!(:message) { create(:message, author: author, category: category) }
    let(:updated_attributes) { { title: "New Title" } }

    before(:each) do
      put api_v1_message_path(message.id), params: { message: updated_attributes }
    end

    it "returns a successful response" do
      expect(response).to have_http_status(:ok)
    end

    it "updates the message" do
      expect(message.reload.title).to eq(updated_attributes[:title])
    end
  end
  context "with invalid params" do
    let(:author) { create(:author) }
    let(:category) { create(:category) }
  
    let!(:message) { create(:message, author: author, category: category) }
  
    let(:invalid_attributes) { { message: { title: nil} } }
  
    before(:each) do
      put api_v1_message_path(message.id), params: invalid_attributes 
    end
  
    it "returns an unprocessable_entity response" do
      expect(response).to have_http_status(422)
    end
  
    it "does not update the message" do
      expect(message.reload.description).to_not eq(invalid_attributes[:message][:description])
    end
  end
  
  context "when the message does not exist" do
    before(:each) do
      put api_v1_message_path(0), params: { message: { title: "New Title" } }
    end

    it "returns a 404 response" do
      expect(response).to have_http_status(404)
    end

    it "returns an error message" do
      expect(JSON.parse(response.body)["message"]).to eq("Record not found")
    end
  end
end


# for destroy action 
describe "DELETE /api/v1/messages/:id" do
    let(:author) { create(:author) }
    let(:category) { create(:category) }
  
    let!(:message) { create(:message, author: author, category: category) }
     let!(:author) { create(:author) }
    let!(:category) { create(:category) }
    let!(:message) { create(:message, author: author, category: category) }
    

    it "deletes the message" do
      expect {
        delete api_v1_message_path(message.id)
      }.to change(Message, :count).by(-1)
    end

    it "returns a successful response" do
      delete api_v1_message_path(message.id)
      expect(response).to have_http_status(:ok)
    end

    it "returns a 'Deleted' message" do
      delete api_v1_message_path(message.id)
      expect(JSON.parse(response.body)).to eq({ "message" => "Deleted" })
    end

  end

  #for custom api - search 
  describe "GET /api/v1/messages/search" do
  let(:author) { create(:author) }
  let(:category) { create(:category) }
  let!(:message1) { create(:message, title: "Test Message", author: author, category: category) }
  let!(:message2) { create(:message, title: "Another Message", author: author, category: category) }

  it "returns messages that match the search query" do
    get :"/api/v1/messages/search", params: { title: "Test" }
    expect(response).to have_http_status(:ok)
    expect(response.body).to include(message1.title)
    expect(response.body).not_to include(message2.title)
  end

  it "returns an empty response for search queries with no matches" do
    get :"/api/v1/messages/search", params: { title: "Invalid Query" }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)).to be_empty
  end
end


  

  

end

