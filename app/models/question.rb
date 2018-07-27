class Question < ApplicationRecord
  belongs_to :survey

  has_many :answers

  validates_presence_of :title
end
