require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'Validation testing for author' do
      
    context 'While creating author' do
      let(:author1) {build :author}
      let(:author2) {build :author,email: "email"}

      it 'should be valid user with all attributes' do
        expect(author1.valid?).to eq(true)
      end
      
      it 'should not be valid user, without valid email' do
        expect(author2.valid?).to eq(false)
      end

    end
  end
end
