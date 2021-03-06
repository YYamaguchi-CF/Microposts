class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :content, length: { maximum: 30 }
    
  has_secure_password
  
  attr_accessor :current_password
  validates :password, presence: { if: :current_password }
  
  #スコープ
  scope :recent, -> { order(created_at: :desc) }
  
  has_many :microposts
  # お気に入り
  has_many :favorites, dependent: :destroy
  has_many :microfavos, through: :favorites, source: :micropost
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_microposts
  	Micropost.where(user_id: self.following_ids + [self.id])
  end
  # お気に入り
  def like(micropost)
  	favorites.find_or_create_by(micropost_id: micropost.id)
  end
  
  def unlike(micropost)
  	favorite = favorites.find_by(micropost_id: micropost.id)
  	favorite.destroy if favorite
  end
  
  def microfavo?(micropost)
  	self.microfavos.include?(micropost)
  end
end
