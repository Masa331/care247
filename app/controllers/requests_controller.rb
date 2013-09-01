require 'time_diff'

class RequestsController < ApplicationController

	layout "backend"

	before_filter :signed_in_user
    before_filter :correct_user, only: [:update, :destroy, :show, :answer_request]

	def show
		@request = Request.find(params[:id])
		@parts = @request.parts
		render :show
	end

	def index
		@all_resolved_requests = Request.all_resolved_requests current_user.id
		@all_unresolved_requests = Request.all_unresolved_requests current_user.id
		render :index
	end

	def update
		@request = Request.find(params[:id])
		if @request.update_attributes(params[:request].permit(:status_flag))
			redirect_to desk_url(@request.desk_id)
		else
			flash[:error] = "Neco se pokazilo"
			redirect_to desk_url(@request.desk_id)
		end
	end

	def answer_request
		@request = Request.find(params[:id])
		Part.create(body: params[:body], request_id: @request.id, user_id: current_user.id)
		MyMailer.answer_request_email(@request.from, @request.desk.desks_mailbox, @request.subject, params[:body]).deliver
		@request.update_attributes(status_flag: 1)
		redirect_to desk_url(@request.desk_id)
	end

	def destroy
		desk_id = Request.find(params[:id]).desk_id
		if Request.find(params[:id]).destroy
			redirect_to desk_url(desk_id)
		else
			flash[:error] = "Neco se pokazilo"
			redirect_to desk_url(desk_id)
		end
	end

	private

	def signed_in_user
        redirect_to root_url unless signed_in?
    end

    def correct_user
        redirect_to root_url unless Request.find(params[:id]).user_id == current_user.id.to_s
    end
end
