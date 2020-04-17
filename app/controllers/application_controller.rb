class ApplicationController < ActionController::Base

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_search_guntypes


    def set_search_guntypes
        @search_guntypes = Guntype.all
    end

    protected

    def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address, :email, :password, :password_confirmation, :province_id])
    end

end
