class Vacancy < ApplicationRecord
  belongs_to :company
  has_many :applicants
  validates :title, presence: { message: I18n.t('input.required_input', param: 'Titulo') }
  validates :location, presence: { message: I18n.t('input.required_input', param: 'Localização') }
  validates :description, length: { minimum: 3, maximum: 1000 , message: 'Error'},
            presence: { message: I18n.t('input.required_input', param: 'Rua') }
  validates :requirements, presence: { message: I18n.t('input.required_input', param: 'Requisitos') }
  validates :salary, presence: { message: I18n.t('input.required_input', param: 'Salário') }
end
