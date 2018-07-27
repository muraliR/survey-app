class Question < ApplicationRecord
  	belongs_to :survey

  	has_many :answers, dependent: :destroy

  	validates_presence_of :title

  	after_create :auto_add_answers


	#this method adds the auto answers since we have not planned adding answers interface
	def auto_add_answers
		person_names = %w(john micheal jordan arya tyrion sansa khal joffrey ramsay)
		answers = ["Very likely","Somewhat likely","Neutral","Somewhat unlikely","Very unlikely","Very satisfied","Somewhat satisfied","Neutral","Somewhat dissatisfied","Very dissatisfied"]

		(1..3).to_a.each do |num|
			person_name = person_names.shuffle.first
			answer = answers.shuffle.first
			self.answers.create(person_name: person_name, answer: answer)
		end
	end
end
