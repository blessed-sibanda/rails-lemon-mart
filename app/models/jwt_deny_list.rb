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
class JwtDenyList < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist
end
