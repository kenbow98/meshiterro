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
  end
end
