class Answer < ApplicationRecord
  belongs_to :question

  validates_presence_of :answer, :person_name
end
