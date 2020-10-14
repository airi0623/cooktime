class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
        
  mount_uploader :icon, IconUploader
  # icon画像用の「iconカラム」と「IconUploaderクラス」を紐づけます。

  with_options presence: true do
    validates :nickname 
    validates :family_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "は全角(漢字・平仮名)で入力してください"}
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "は全角(漢字・平仮名)で入力してください"}
  end
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z{6,}/i, message: "は英数字で入力してください"}
end
