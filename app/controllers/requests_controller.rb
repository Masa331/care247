# encoding: UTF-8

class RequestsController < ApplicationController

	layout "signed_in"

	before_filter :signed_in_user
    before_filter :correct_user, only: [:update, :destroy, :show]

	def show
		@request = Request.find(params[:id])
		render :show
	end

	def update
	end

	def destroy
	end

	private

	def signed_in_user
        redirect_to root_url unless signed_in?
    end

    def correct_user
        redirect_to root_url unless Request.find(params[:id]).user_id == current_user.id.to_s
    end
end
