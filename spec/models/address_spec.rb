# == Schema Information
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  city       :string           not null
#  line1      :string           not null
#  line2      :string
#  state      :string           not null
#  zip        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_addresses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Address, type: :model do
  describe "validations" do
    it { should validate_presence_of(:line1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
  end

  describe "associations" do
    it { should belong_to(:user) }
  end
end
