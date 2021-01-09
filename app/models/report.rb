class Report < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  mount_uploader :repo_image, RepoImageUploader
end
