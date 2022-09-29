class Song < ApplicationRecord
    has_and_belongs_to_many :authors
    accepts_nested_attributes_for :authors

    has_many :comments, as: :commentable, dependent: :destroy
    accepts_nested_attributes_for :comments, allow_destroy: true

    has_one_attached :image_cover
end
