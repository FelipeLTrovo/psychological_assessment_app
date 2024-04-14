class InstrumentsController < ApplicationController
  before_action :authenticate_psychologist!
  before_action :set_instrument, only: %i[ show edit update destroy ]

  def index
    @instruments = Instrument.all
  end

  def show
  end

  def new
    @instrument = Instrument.new
  end
  
  def edit
  end
  
  def create
    @form = InstrumentForm.new(instrument_params)
    @instrument = @form.save

    if @instrument.save
      redirect_to instrument_url(@instrument), notice: "Instrument was successfully created."
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def update
    @form = InstrumentForm.new(instrument_params.merge(id: params[:id])).update

    if @instrument
      redirect_to instrument_url(@instrument), notice: "Instrument was successfully updated." 
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @instrument.destroy!

    redirect_to instruments_url, notice: "Instrument was successfully destroyed." 
  end

  private

  def set_instrument
    @instrument = Instrument.find(params[:id])
  end

  def instrument_params
    params.permit(:name, :question_1, :question_2, :question_3, :question_4, :question_5)
  end
end
