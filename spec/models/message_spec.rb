require 'rails_helper'

RSpec.describe Message, type: :model do


    describe "message-validations" do
        
        let(:author) {build :author}

        let(:category) { create(:category) }
        let(:message) {build(:message,author: author, category: category)}
        let(:message1) {create(:message,description:"", author: author, category: category)}
        let(:message2) {build :message,title: message.title,author: author,  category: category}
        it "is valid with all attributes" do  
          expect(message).to be_valid
        end

        #having associations
        it 'should belong to  a author' do
            expect(message.author).to eq(author)
        end

      
        

        # rspec for callback
        it "set the description of message model" do
           # debugger
            expect(message1.description).to eq("Description is not provided by author.")
        end
        
        # rspec for active record validations
        it "should raise invalid record exception for duplicate title" do
          #debugger
          message.save
          expect(message2.save).to eq(true)
          end
        

    end
  
  
    
end 
