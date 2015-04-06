class SessionsController < ApplicationController
	include SessionsHelper
	def new
	end
	
	def create
		Rails.logger.info "I'm here: #{params}"
		host = Host.find_by_email(params[:session][:email])
		if host && host.authenticate(params[:session][:phone])
			sign_in host
			redirect_to host
		else
			flash[:error] = I18n.t('shared.incorrect_email_or_password')
			render :new
		end
	end
end