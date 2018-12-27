class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
        @user = User.from_omniauth(request.env["omniauth.auth"])
        @user.update_profile(request.env["omniauth.auth"])
        @user.update_credential(request.env["omniauth.auth"])

        if @user.persisted?
            sign_in @user, :event => :authentication #this will throw if @user is not activated
            set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
        else
            # Removing extra as it can overflow some session stores
            session["devise.google_data"] = request.env["omniauth.auth"].except(:extra)
        end
        redirect_to root_path
    end
    def facebook
        @user = User.from_omniauth(request.env["omniauth.auth"])
        @user.update_profile(request.env["omniauth.auth"])
        @user.update_credential(request.env["omniauth.auth"])

        if @user.persisted?
            sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
            set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
        else
            session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra)
            redirect_to root_path
        end
    end

    def failure
        redirect_to root_path
    end
end