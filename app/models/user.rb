class User < ApplicationRecord

  
  has_many :comments, dependent: :destroy

  has_many :messages, through: :comments
  has_many :reactions, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



         enum role: [:user, :admin]
         after_initialize :set_default_role, :if => :new_record?
         def set_default_role
           self.role ||= :user
         end
         
  validates :email, format: URI::MailTo::EMAIL_REGEXP

  def self.authenticate(email, password)
  user = User.find_for_authentication(email: email)
  user&.valid_password?(password) ? user : nil
  end
 
end  