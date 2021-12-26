# == Schema Information
#
# Table name: phones
#
#  id         :bigint           not null, primary key
#  digits     :string           not null
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_phones_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :phone do
    type { Phone::PHONE_TYPES.sample }
    digits { Faker::PhoneNumber.phone_number }
    user { build :user }
  end
end
