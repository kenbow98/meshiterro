class UsersController < ApplicationController
  def show
    #URLに記載されたIDを参考に、必要なUserモデルを取得する」処理
    @user = User.find(params[:id])
    #これは、アソシエーションを持っているモデル同士の記述方法です。
    #上記のように記述することで、特定のユーザ（@user）に関連付けられた投稿全て（.post_images）を取得し
    #@post_imagesに渡す という処理を行うことができます。
    #結果的に、全体の投稿ではなく、個人が投稿したもの全てを表示できます。
    @post_images = @user.post_images
  end

  def edit
    @user = User.find(params[:id])
  end

   def update
    #ユーザーの取得
    @user = User.find(params[:id])
    #ユーザーのアップデート
    @user.update(user_params)
    # ユーザーの詳細ページへのパス
    redirect_to user_path(@user)
   end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
