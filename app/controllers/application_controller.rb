class ApplicationController < ActionController::Base
  #このように記述することで、ログイン認証が済んでいない状態でトップページ以外の画面にアクセスしても、
  #ログイン画面へリダイレクトするようになります。 また、ログイン認証が済んでいる場合には全てのページにアクセスすることができます。
  #before_actionメソッドは、このコントローラが動作する前に実行されます。
  #今回の場合、app/controllers/application_controller.rbファイルに記述したので、 すべてのコントローラで、最初にbefore_actionメソッドが実行されます。
  #authenticate_userメソッドは、devise側が用意しているメソッドです。 :authenticate_user!とすることによって、
  #「ログイン認証されていなければ、ログイン画面へリダイレクトする」機能を実装できます。
  #exceptは指定したアクションをbefore_actionの対象から外します。 Meshiterroではトップページのみログイン状態に関わらず、
  #アクセス可能とするためにtopアクションを指定しています。
  before_action :authenticate_user!, except: [:top]
  #device利用の機能(ユーザー登録、ログイン認証など)が使われる前にconfigure_permitted_parametersメソッドが実行される
  before_action :configure_permitted_parameters, if: :devise_controller?

  #after_sign_in_path_forははDeviseが用意しているメソッドで、サインイン後にどこに遷移するかを設定しているメソッド
  def after_sign_in_path_for(resource)
    post_images_path
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
