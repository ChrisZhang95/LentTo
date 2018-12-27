class CredentialsController < ApplicationController
    def update
        redirect_to root_path if current_user.update credential_params
     end
  
     private
  
     def credential_params
        params.require(:user).permit(credential_attributes: [:token, :refresh_token, :expires, :expires_at])
     end
end
