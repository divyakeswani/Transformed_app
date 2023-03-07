require 'rails_helper'

RSpec.describe UserRole, type: :model do
  it 'has a valid factory' do
    expect(build(:user_role)).to be_valid
  end
  let(:user_role) { build(:user_role) }

  describe 'ActiveRecord associations' do
    # Associations
    it { expect(user_role).to belong_to(:user) }
    it { expect(user_role).to belong_to(:organization) }
    it { expect(user_role).to belong_to(:role) }
  end
end
