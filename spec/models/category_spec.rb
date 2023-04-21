require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Validation testing for category ' do
      
    context 'While creating category' do
      let(:category1) {build :category}

      it 'should be valid category with all attributes' do
        expect(category1.valid?).to eq(true)
      end
      
    end
  end

end
