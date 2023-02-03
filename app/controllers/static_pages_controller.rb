# frozen_string_literal: true

# app/controllers/static_pages_controller.rb
class StaticPagesController < ApplicationController
  # skip_before_action :authenticate_user!
  # GET '/landing_page'
  def landing_page; end

  # GET '/dashboard'
  def dashboard; end
end
