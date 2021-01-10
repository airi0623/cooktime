class Report < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  mount_uploader :repo_image, RepoImageUploader

  with_options presence: true do
    validates :user_id
    validates :repo_image
    validates :repo
  end
end
