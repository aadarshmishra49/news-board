class Message < ApplicationRecord
    paginates_per 7
    belongs_to :author
    belongs_to :category
    has_many :comments, dependent: :destroy
    has_many :users, through: :comments
    has_many :reactions, as: :likeable,dependent: :destroy
   
    attribute :created_at, :datetime, default: -> { Time.now }


    #validates title and body
    validates :title, presence: true
     
  
    #model - validations
    validates :category, presence: true
    validates :author, presence: true


    #callbacks
    before_save :normalize_message


    before_update :update_updated_at


    private
  
        def normalize_message
            self.title = title.strip
            
            if self.description == ""
                self.description ="Description is not provided by author."
            end

        end 

        def update_updated_at
        self.updated_at = Time.now
        end
    

end 
