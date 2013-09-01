class DesksController < ApplicationController

    layout "backend"

    before_filter :signed_in_user
    before_filter :correct_user, only: [:edit, :update, :destroy, :show]

    def new
        @desk = Desk.new
    end

    def create
        @desk = current_user.desks.build(params[:desk].permit(:name, :notificate, :desks_mailbox))
        if @desk.save
            flash[:success] = "Podpora byla uspesne vytorena"
            redirect_to @desk
        else
            flash[:error] = "Podporu se nepodarilo vytvorit, zkuste to prosim znovu"
            render :new
        end
    end

    def edit
        redirect_to root_url unless @desk = Desk.find(params[:id])
    end

    def update
        if @desk = Desk.find(params[:id])
            if @desk.update_attributes(params[:desk].permit(:name, :notificate, :desks_mailbox))
                flash[:success] = "Udaje byly uspesne zmeneny"
                redirect_to @desk
            else
                flash[:error] = "Udaje se nepodarilo ulozit, zkuiste to znovu."
                render :show
            end
        end
    end

    def destroy
        if @desk = Desk.find(params[:id])
            @desk.destroy
            redirect_to current_user
        else
            redirect_to root_url
        end
    end

    def show
        if @desk = Desk.find(params[:id])
            @resolved_requests = @desk.resolved_requests
            @unresolved_requests = @desk.unresolved_requests
            render :show
        else
            redirect_to root_url
        end                
    end

    private

    def signed_in_user
        redirect_to root_url unless signed_in?
    end

    def correct_user
        redirect_to root_url unless Desk.find(params[:id]).user_id == current_user.id
    end
end
