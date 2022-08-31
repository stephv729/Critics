class Company < ApplicationRecord
  has_many :involved_companies, dependent: :destroy
  has_many :games, through: :involved_companies
  has_many :critics, as: :criticable, dependent: :destroy

  has_one_attached :cover # Para poder adjuntar una imagen a company
  
  def available_critics(user_id, user_role)
    return critics if user_role == "admin"

    critics.select { |c| c.user_id == user_id || c.approved? }
  end
  
end
