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
class Phone < ApplicationRecord
  belongs_to :user

  PHONE_TYPES = [
    MOBILE = "mobile",
    WORK = "work",
    HOME = "home",
  ]

  validates :digits, presence: true
  validates_inclusion_of :type, in: PHONE_TYPES
end
