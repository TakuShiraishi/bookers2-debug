class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable

  # belongs_to :books
  # has_one_attached :profile_image

  # validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true



  # def get_profile_image
  #   (profile_image.attached?) ? profile_image : 'no_image.jpg'
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_one_attached :profile_image
         has_many :books, dependent: :destroy

         validates :name, length: { minimum: 2, maximum: 20 },uniqueness: true
         validates :introduction, length: { maximum: 50 }

    def get_profile_image(width, height)
         unless profile_image.attached?
         file_path = Rails.root.join('app/assets/images/no_image.jpg')
         profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
         end
         profile_image.variant(resize_to_limit: [width, height]).processed
    end
end