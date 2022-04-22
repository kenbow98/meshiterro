class ApplicationController < ActionController::Base
  #device利用の機能(ユーザー登録、ログイン認証など)が使われる前にconfigure_permitted_parametersメソッドが実行される
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

#configure_permitted_parametersメソッドでは、devise_parameter_sanitizer.permitメソッドを使うことで
#ユーザー登録(sign_up)の際に、ユーザー名(name)のデータ操作を許可しています。
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
