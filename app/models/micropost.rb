class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :favorites, foreign_key: 'micropost_id', dependent: :destroy
  has_many :users, through: :favorites
  
  has_one_attached :micropost_image
  attribute :new_micropost_image
  
  before_save do
  	if new_micropost_image
  		self.micropost_image = new_micropost_image
  	end
  end
end
