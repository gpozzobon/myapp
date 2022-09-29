class Author < ApplicationRecord
    has_and_belongs_to_many :songs

    has_many :comments, as: :commentable, dependent: :destroy
    accepts_nested_attributes_for :comments, allow_destroy: true

    has_one_attached :profile_image

    def complete_name
        "#{name} #{surname}"
    end
end
