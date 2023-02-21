# frozen_string_literal: true

# app/presenters/users/invitation_presenter.rb
module Users
  class InvitationPresenter
    # Initialize invitation_presenter
    def initialize(g)
      @group = g
    end

    def leader_confirmed
      if @group.leader.confirmed?
        return true
      else
        return false
      end
    end
  end
end