class ApplicationController < ActionController::Base
    layout :layout_by_resource

    private

    def layout_by_resource
        if devise_controller?
            "devise"
        else
            "application"
        end
    end

    def after_sign_out_path_for(resource_or_scope)
        request.referrer
    end
end
