class Book < ApplicationRecord
  is_impressionable
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true

  def favorited_by?(user)
    favorites.exists?(user_id:user.id)
  end

  def self.last_week # メソッド名は何でも良いです
    date = Date.current
    Book.joins(:favorites).where(favorites: { created_at: date.weeks_ago(1)..date }).group(:id).order("count(book_id) desc")
  end
end
