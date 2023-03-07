require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end
  let(:user) { build(:user) }

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(user).to have_one(:user_profile) }
    it { expect(user).to have_one(:organization) }
    it { expect(user).to have_one(:user_role) }
    it { expect(user).to have_many(:groups) }
    it { expect(user).to have_many(:organization_memberships) }
  end
end
