class QuestionsController < ApplicationController

	include SurveyConcern

	before_action :get_survey, only: [:add,:create_question]
	before_action :get_question, only: [:destroy, :edit, :update]
	before_action :filter_params, only: [:create_question,:update]

	def add
		@question = @survey.questions.new
	end

	def create_question
		@question = @survey.questions.new(@question_params)
		if @question.save
			flash[:notice] = I18n.t('success.saved')
		else
			flash[:error] = @question.errors.full_messages.first
		end
		redirect_to survey_path(@survey)
	end

	def destroy
		@survey = @question.survey
		@question.destroy
		flash[:notice] = I18n.t('success.deleted')
		redirect_to survey_path(@survey)
	end

	def edit
	end

	def update
		@question.update(@question_params)
		if @question.errors.any?
			flash[:error] = @question.errors.full_messages.first
			redirect_to survey_path(@survey)
		else
			flash[:notice] = I18n.t('success.updated')
			redirect_to survey_path(@question.survey)
		end
	end

	private

	def filter_params
	    @question_params = params.require(:question).permit(:title)
	end

	def get_question
		@question = Question.find_by(id: params[:id])
	    if @question.nil?
	      flash[:error] = "Invalid Question Request"
	      return redirect_to surveys_path
	    end
	end
end
