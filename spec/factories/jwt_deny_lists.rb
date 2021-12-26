# == Schema Information
#
# Table name: jwt_deny_lists
#
#  id         :bigint           not null, primary key
#  exp        :string
#  expired_at :datetime
#  jti        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_jwt_deny_lists_on_jti  (jti)
#
FactoryBot.define do
  factory :jwt_deny_list do
    jti { "MyString" }
    expired_at { "2021-12-26 12:13:59" }
    exp { "MyString" }
  end
end
