class Game < ApplicationRecord
  has_many :involved_companies, dependent: :destroy
  has_many :companies, through: :involved_companies
  has_many :expansions, class_name: "Game",
                        foreign_key: "parent_id",
                        dependent: :destroy,
                        inverse_of: "parent"
  has_many :critics, as: :criticable, dependent: :destroy
  belongs_to :parent, class_name: "Game", optional: true
  has_and_belongs_to_many :platforms
  has_and_belongs_to_many :genres
  enum category: { main_game: 0, expansion: 1 }
  has_one_attached :cover # Para poder adjuntar una imagen al game

  validates :name, uniqueness: true, presence: true
  validates :summary, presence: true
  validates :rating, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
  validate :parent
  validate :expansion

  def available_critics(user_id, user_role)
    return critics if user_role == "admin"

    critics.select { |c| c.user_id == user_id || c.approved? }
  end

  def publishers
    InvolvedCompany.where(game_id: id, publisher: true)
  end

  def developers
    InvolvedCompany.where(game_id: id, developer: true)
  end

  private

  def parent
    return unless category == "main_game" && !parent_id.nil?

    errors.add(:parent_id, "must be blank. Select 'no parent'")
  end

  def expansion
    return unless category == "expansion" && parent_id.nil?

    errors.add(:parent_id, "must not be blank")
  end
end
