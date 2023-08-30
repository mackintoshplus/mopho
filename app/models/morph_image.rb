class MorphImage < ApplicationRecord
  has_one_attached :image
  has_one_attached :image2
  has_one_attached :video
end
