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
require "rails_helper"

RSpec.describe Phone, type: :model do
  describe "validations" do
    it { should validate_length_of(:digits) }
  end

  describe "phone type validation" do
    let(:phone) { build :phone }

    it "should only allow valid phone_types" do
      Phone::PHONE_TYPES.each do |type|
        phone.type = type
        expect(phone).to be_valid
      end
    end

    it "should reject invalid phone_types" do
      invalid_phones_types = ["", "unknown", "private"]
      invalid_phones_types.each do |type|
        phone.type = type
        expect(phone).to be_invalid
      end
    end
  end

  describe "associations" do
    it { should belong_to(:user) }
  end
end
