require 'rails_helper'

RSpec.describe Reaction, type: :model do
  context 'like ' do
    let(:message){build :message}
    let(:comment){build :comment}
    let(:user){build :user}


    let(:like1){build :reaction,likeable: message,user:user}
    let(:like2){build :reaction,likeable: comment,user:user}
    let(:like3){build :reaction}

    
    it 'like on message' do
        expect(like1.valid?).to eq(true)
    end
    it 'message like' do
      expect(like1.likeable).to eq(message)
    end

    it 'like on comment' do
        expect(like2.valid?).to eq(true)
    end
  
    it 'comment like' do
      expect(like2.likeable).to eq(comment)
    end
   
    it 'invalid ' do
      expect(like3.valid?).to eq(false)
    end
    

  end
 
end

