class ProfilesController < ApplicationController
    before_action :authenticate_user!


    def show
      @average = current_user.uratings.average(:score)
    end

    def update
      redirect_to action: 'show' if current_user.update profile_params
    end

    private

    def profile_params
      params.require(:user).permit(
        profile_attributes: [
          :first_name, :last_name, :phone, :picture, :location, :address, :avatar, :occupation, :facebook, :linkedin, :id
        ]
      )
    end





end
