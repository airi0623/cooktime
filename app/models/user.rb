class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
        
  mount_uploader :icon, IconUploader
  # icon画像用の「iconカラム」と「IconUploaderクラス」を紐づけます。

  has_many :choices
  has_many :recipes, through: :choices
  has_many :likes
  has_many :recipes, through: :likes
  has_many :reports

  with_options presence: true do
    validates :nickname 
    validates :family_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "は全角(漢字・平仮名)で入力してください"}
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "は全角(漢字・平仮名)で入力してください"}
    validates :icon
  end
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z{6,}/i, message: "は英数字で入力してください"}

  def self.guest
    find_or_create_by!(email: 'guest@gmail.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.password = SecureRandom.alphanumeric(10)
      user.nickname = "かんたん太郎"
      user.email = 'guest@gmail.com'
      user.profile = "このアカウントを使うとかんたんにログインしていただけます。
      採用担当者様がよりかんたんにサイトを閲覧していただけるよう設置いただいました。"
      user.family_name = "かんたん"
      user.first_name = "太郎"
      user.icon = open('./db/fixtures/icon.png')
    end
  end
end
