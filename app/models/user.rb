class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  has_many :critics, dependent: :destroy

  validates :role, inclusion: ["admin", "regular"]

  def admin?
    role == "admin"
  end

  # Para consultar los ID de los admins
  def self.admin_ids
    User.where(role: "admin").map(&:id)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider 
      user.uid = auth.uid
      user.username = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,6]
      user.save
    end
  end
end
