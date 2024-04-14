class InstrumentsApplicationsController < ApplicationController
  before_action :authenticate_psychologist!
  before_action :set_application, only: %i[ show destroy ]# edit update destroy ]

  def index
    @instrument_applications = InstrumentApplication.where(psychologist_id: current_psychologist.id)
  end

  def show
  end

  def destroy
    @application.destroy!

    redirect_to instruments_applications_url, notice: "Application was successfully destroyed."
  end

  private
  
  def set_application
    @application = InstrumentApplication.find(params[:id])
  end
end
