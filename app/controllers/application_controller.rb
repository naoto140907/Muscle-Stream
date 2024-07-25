class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    # サインアップ時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :photo])
    # アカウント編集の時にnameとprofileのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :photo])
  end

  def after_sign_in_path_for(resource)
    user_path(current_user.id)#遷移先のパス
  end

  def after_sign_up_path_for(resource)
    user_path(current_user.id)
  end
end
