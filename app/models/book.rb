class Book < ApplicationRecord
  belongs_to :user
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :view_counts, dependent: :destroy
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }

  has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).
  at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end