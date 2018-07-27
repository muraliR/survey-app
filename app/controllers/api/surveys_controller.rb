class Api::SurveysController < ApplicationController
	include SurveyConcern

	before_action :is_taker
end
