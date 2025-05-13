class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users

  has_one_attached :image

  def get_group_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/group_image.jpg')
      image.attach(io: File.open(file_path), filename: 'group_image.jpg')
    end
    image
  end
end
