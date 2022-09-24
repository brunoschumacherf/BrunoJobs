class Applicant < ApplicationRecord
  belongs_to :vacancy
  validates :name, presence: { message: I18n.t('input.required_input', param: 'Nome') }
  has_one_attached :curriculum
end
