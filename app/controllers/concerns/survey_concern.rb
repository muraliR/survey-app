module SurveyConcern
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!, unless: -> { request.format.json? }
  end

  def index
    @surveys = Survey.all
  end


  def get_survey
    @survey = Survey.find_by(id: params[:id])
    if @survey.nil?
      flash[:error] = "Invalid Survey Request"
      return redirect_to surveys_path
    end
  end
end