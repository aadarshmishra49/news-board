class Author < ApplicationRecord
  has_many :messages, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def self.authenticate(email, password)
    author = Author.find_for_authentication(email: email)
    author&.valid_password?(password) ? author : nil
  end
        
end
