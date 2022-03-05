class Group < ApplicationRecord
  has_many :group_users,dependent: :destroy
  has_many :users,through: :group_users
  accepts_nested_attributes_for :group_users, allow_destroy: true
  belongs_to :owner,class_name:"User"

  has_one_attached :group_image

  def get_group_image
    (group_image.attached) ? group_image : 'no_image.jpg'
  end
end