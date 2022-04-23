class ApplicationController < ActionController::Base
  #device利用の機能(ユーザー登録、ログイン認証など)が使われる前にconfigure_permitted_parametersメソッドが実行される
  before_action :configure_permitted_parameters, if: :devise_controller?

  #after_sign_in_path_forははDeviseが用意しているメソッドで、サインイン後にどこに遷移するかを設定しているメソッド
  def after_sign_in_path_for(resource)
    about_path
  end
  #after_sign_out_path_forはafter_sign_in_path_forと同じくDeviseが用意しているメソッドで
  #サインアウト後にどこに遷移するかを設定するメソッドです。
  def after_sign_out_path_for(resource)
    about_path
  end

  protected

#configure_permitted_parametersメソッドでは、devise_parameter_sanitizer.permitメソッドを使うことで
#ユーザー登録(sign_up)の際に、ユーザー名(name)のデータ操作を許可しています。
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
