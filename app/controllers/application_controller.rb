class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # deviseのストロングパラメータ追加設定
  def configure_permitted_parameters
    # 新規登録時(sign_up)にnameというキーのパラメーターを追加で許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # ユーザー更新時(/users/edit)にname,comment,web_pageというキーのパラメーターを追加で許可する
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :comment, :web_page])
  end
end
