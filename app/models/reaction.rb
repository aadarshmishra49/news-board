class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :likeable,polymorphic: true
 
  scope :message, ->{ where(:likeable_type => 'Message') }
  scope :comment, -> { where(:likeable_type => 'Comment') }


end
 