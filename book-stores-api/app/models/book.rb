class Book < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :author
end
