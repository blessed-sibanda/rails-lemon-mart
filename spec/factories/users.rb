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
FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { "my-secret" }
    email { "user-#{SecureRandom.hex(4)}@example.com" }
    role { User::ROLES.sample }
    line1 { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
  end
end
