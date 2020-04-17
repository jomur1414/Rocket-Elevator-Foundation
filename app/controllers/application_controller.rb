class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :set_current_user

    def require_admin
      # depending on your auth, something like...
      redirect_to main_app.root_path unless current_user.is_employee(current_user.email)
    end

  

    protect_from_forgery with: :exception

     before_action :configure_permitted_parameters, if: :devise_controller?

     protected

     
          def configure_permitted_parameters
               devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:firstName,:lastName, :email, :phoneNumber, :companyName, :job_title, :password)}

               devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:firstName, :lastName, :email, :password, :phoneNumber,:companyName,  :job_title, :current_password)}

          
          end

    private
  
    def set_current_user
      if session[:user_id]
        @current_user = User.find(session[:user_id])
      end
    end
  end
