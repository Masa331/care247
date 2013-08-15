class DesksController < ApplicationController

    before_filter :signed_in_user
    before_filter :correct_user, only: [:update, :destroy, :show]

    def new
        @desk = Desk.new
    end

    def create
        @desk = current_user.desks.build(params[:desk].permit(:name))
        if @desk.save
            flash[:success] = "Podpora byla uspesne vytorena"
            redirect_to @desk
        else
            flash[:error] = "Podporu se nepodarilo vytvorit, zkuste to prosim znovu"
            render :new
        end
    end

    def update
        if @desk = Desk.find(params[:id])
            if @desk.update_attributes(params[:desk].permit(:name, :notificate))
                flash[:success] = "Udaje byly uspesne zmeneny"
                redirect_to @desk
            else
                flash[:error] = "Udaje se nepodarilo ulozit, zkuiste to znovu."
                render :show
            end
        end
    end

    def destroy
        @desk = Desk.find(params[:id])
        @desk.destroy
        redirect_to current_user
    end

    def show
        @desk = Desk.find(params[:id])
        render :show
    end

    private

    def signed_in_user
        redirect_to root_url unless signed_in?
    end

    def correct_user
        # rozmyslet, proc tohle nejde rovnou nacist v #show, #update atd misto novych query
        @desk = current_user.desks.find_by_id(params[:id])
        redirect_to root_url if @desk.nil?
    end
end
