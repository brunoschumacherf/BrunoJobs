class VacanciesController < ApplicationController
  skip_before_action :authenticate_company!, only:  %i[ show all ]
  before_action :set_vacancy, only: %i[ show edit update destroy clone ]

  def all
    @vacancies = Vacancy.where(available: true).order(created_at: :desc).page(params[:page]).per(10)
  end
  # GET /vacancies or /vacancies.json
  def index
    @vacancies = current_company.vacancies.order(
      created_at: :desc
    ).page(params[:page]).per(10)
  end

  # GET /vacancies/1 or /vacancies/1.json
  def show; end

  def clone
    @new_vacancy = Vacancy.new(available: true)
    @new_vacancy.clone(@vacancy)
    @title = @vacancy.title
    @vacancy = @new_vacancy
  end

  # GET /vacancies/new
  def new
    @vacancy = Vacancy.new(available: true)
  end

  # GET /vacancies/1/edit
  def edit; end

  # POST /vacancies or /vacancies.json
  def create
    @vacancy = current_company.vacancies.build(vacancy_params)
    unless current_company.vacancies.where(vacancy_params).first.nil?
      return respond_to do |format|
        format.html { redirect_to '/', notice: "Essa vaga já existe" }
      end
    end
    respond_to do |format|
      if @vacancy.save
        format.html { redirect_to vacancy_url(@vacancy), notice: I18n.t('controller.create.sucess', type: 'Vaga') }
        format.json { render :show, status: :created, location: @vacancy }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vacancies/1 or /vacancies/1.json
  def update
    respond_to do |format|
      if @vacancy.update(vacancy_params)
        format.html { redirect_to vacancy_url(@vacancy), notice: I18n.t('controller.update.sucess', type: 'Vaga') }
        format.json { render :show, status: :ok, location: @vacancy }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vacancies/1 or /vacancies/1.json
  def destroy
    @vacancy.destroy

    respond_to do |format|
      format.html { redirect_to vacancies_url, notice: I18n.t('controller.delete.sucess', type: 'Vaga') }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_vacancy
    @vacancy = Vacancy.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vacancy_params
    params.require(:vacancy).permit(:title, :location, :description, :requirements, :salary, :available, :company_id)
  end
end
