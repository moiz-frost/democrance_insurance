# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit

  private

  def active_admin_controller?
    is_a?(ActiveAdmin::BaseController)
  end

  def user_for_paper_trail
    return unless active_admin_controller?

    current_admin_user&.email
  end
end
