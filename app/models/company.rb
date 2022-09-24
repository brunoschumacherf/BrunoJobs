class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :vacancies
  validates :name, presence: { message: I18n.t('input.required_input', param: 'Nome da Empresa') }
  validates :description, length: { minimum: 3, maximum: 1000, message: I18n.t('input.required_input_lenght') }
end
