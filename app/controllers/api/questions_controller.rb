class Api::QuestionsController < ApplicationController

	include SurveyConcern

	# Skip the authenticity token only for this controller for now.
	# Because we are not allowing any post method Survey api controller.
	skip_before_action :verify_authenticity_token 


	before_action :is_taker #check if api user (taker) accesing the resource
	before_action :get_survey # this method implemented in controllers/concern/survey_concern.rb
	before_action :filter_params, only: [:create]

	def create
		@question = @survey.questions.new(@question_params)
		if @question.save
			return render json: {success: true, question_id: @question.id}, status: 201
		else
			return render json: {success: false, message: @question.errors.full_messages.first}, status: 422
		end
	end

	def destroy
		@question = @survey.questions.find_by(id: params[:question_id])
		if @question.present?
			@question.destroy
			return render json: {success: true}, status: 200
		else
			return render json: {success: false, message: I18n.t('errors.invalid_question')}, status: 422
		end
	end

	private

	def filter_params
		if params[:question].present?
	    	@question_params = params.require(:question).permit(:title)
	    else
	    	return render json: {success: false, message: "question params required!!"}, status: 422
	    end
	end

end
