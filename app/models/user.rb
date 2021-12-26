# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  city                   :string           not null
#  date_of_birth          :date
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  last_name              :string           not null
#  level                  :integer
#  line1                  :string           not null
#  line2                  :string
#  middle_name            :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string           default("none")
#  state                  :string           not null
#  user_status            :boolean          default(TRUE)
#  zip                    :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  include PgSearch::Model

  self.per_page = 15
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenyList

  pg_search_scope :search,
                  against: {
                    email: "A",
                    first_name: "A",
                    last_name: "A",
                    role: "B",
                    middle_name: "C",
                  }, using: {
                    tsearch: { prefix: true },
                  }

  ROLES = [
    NONE = "none",
    MANAGER = "manager",
    CLERK = "clerk",
    CASHIER = "cashier",
  ]

  validates :first_name, :last_name, :email, presence: true
  validates :line1, :city, :state, :zip, presence: true

  validates_inclusion_of :role, in: ROLES, message: "'%{value}' is not valid role. Valid roles are ('none', 'manager', 'cashier', 'clerk')"

  has_many :phones
end
