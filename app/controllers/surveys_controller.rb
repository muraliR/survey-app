class SurveysController < ApplicationController
	include SurveyConcern

	before_action :is_admin
	before_action :filter_params, only: [:create,:update]
	before_action :get_survey, only: [:edit,:update,:destroy,:show]

	def new
		@survey = Survey.new
	end

	def create
		@survey = Survey.new(@survey_params)
		if @survey.save
			flash[:notice] = I18n.t('success.saved')
			redirect_to surveys_path
		else
			flash[:error] = @survey.errors.full_messages.first
			redirect_to new_survey_path
		end
	end

	def show
		# get the questions collections to show in survey show page
		# to avoid N+1 query, doing eager_load
		@questions = @survey.questions.eager_load(:answers)
	end

	def edit
	end

	def update
		@survey.update(@survey_params)
		if @survey.errors.any?
			flash[:error] = @survey.errors.full_messages.first
			redirect_to edit_survey_path(@survey)
		else
			flash[:notice] = I18n.t('success.updated')
			redirect_to surveys_path
		end
	end

	def destroy
		@survey.destroy
		flash[:notice] = I18n.t('success.deleted')
		redirect_to surveys_path
	end

	private

	def filter_params
	    @survey_params = params.require(:survey).permit(:title)
	end
end
