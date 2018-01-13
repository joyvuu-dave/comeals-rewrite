class ResidentsController < ApplicationController
  # GET /residents/login (www)
  def login
  end

  # GET /residents/calendar (subdomains)
  def calendar
    @community = Community.find_by(slug: subdomain)
    @resident_id = current_resident&.id
  end

  # GET /residents/profile (subdomains)
  def profile
    @community = Community.find_by(slug: subdomain)
    @resident_id = current_resident&.id
    @resident = current_resident
  end

  # GET /residents/react-calendar (subdomains)
  def react_calendar
  end

  # GET /residents/password-reset
  def password_reset
  end

  # GET /residents/password-reset/:token
  def password_new
    resident = Resident.find_by(reset_password_token: params[:token])
    @email = resident&.email
    @token = resident&.reset_password_token
  end

end
