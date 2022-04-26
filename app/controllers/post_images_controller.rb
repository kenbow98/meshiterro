class PostImagesController < ApplicationController
  def new
    #@post_image には form_with に渡すための「空のモデル」を用意したいです。
    @post_image = PostImage.new
  end

  #投稿データの保存
  def create
    #このコードでは、投稿するデータを PostImage モデルに紐づくデータとして保存する準備をしていて
    #フォームに入力されたデータ(shop_name や caption,image など)が、@post_image に格納されることになっています。
    @post_image = PostImage.new(post_image_params)
    #1  user_idは画像投稿を行う際に、「どのユーザーが投稿したのか」を「ユーザーの ID で判断する」ためのカラム
    #2  @post_image は、PostImage.new によって生成された、PostImage の空のモデルです。
    #   空のモデルでは、PostImage モデルで定義したカラムを@post_image.user_idのように、"[モデル名].[カラム名]"
    #   という形で繋げることで、PostImage モデルに紐づくカラムの値を取得したり、逆に値を代入することができる
    #3  current_user は、コードに記述するだけで、ログイン中のユーザーの情報を取得できる便利な記述です。
    #   ヘルパーメソッドと呼ばれるものの一種で、devise をインストールすることで使えるようになります。
    #4  この行のまとめ
    #   @post_image(投稿データ)のuser_idを、current_user.id(今ログインしているユーザーの ID)に
    #   指定することで投稿データに、今ログイン中のユーザーの ID を持たせることができる。
    @post_image.user_id = current_user.id
    #  if文を用いて、対象のカラム（ここではimageとshop_name）にデータが保存された場合はsaveメソッド(@post_image.save)がtrueになり、
    #  今まで通りredirect_toによりリダイレクト処理が走り、
    #  バリデーションなどにより保存できなかった場合はsaveメソッドがfalseになり、
    #  renderによりpost_images/new.html.erbが表示され投稿ページを再表示するように設定します。
    if @post_image.save
      redirect_to post_images_path
    else
      render :new
    end

  end

  def index
    #1 @post_imagesにはpost_imagesテーブル内に存在する全てのレコードのインスタンスを代入します。
    #. @post_images = PostImage.all
    #2 indexアクションの中では、postimagesテーブル内の全データが取得されていました。
    #  これを、1ページ分の決められた数のデータだけを、新しい順に取得するように変更しています。
    #  pageメソッドは、kaminariをインストールしたことで使用可能になったメソッドです。
    @post_images = PostImage.page(params[:page])
  end

  def show
    #@post_imageには特定のidのPostImageモデルを格納させます。
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to '/post_images'
  end

  #投稿データのストロングパラメータ
  private
  #post_image_paramsメソッドでは、フォームで入力されたデータが、投稿データとして許可されているパラメータ
  #かどうかをチェックしています。
  def post_image_params
    params.require(:post_image).permit(:shop_name, :image, :caption)
  end

end