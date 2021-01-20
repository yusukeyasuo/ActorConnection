class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def update
    @user.update_without_password(user_params)
    redirect_to mypage_users_path
  end

  def mypage
  end

  def update_password
    if password_set?
      if @user.update_password(user_params)
        flash[:notice] = "パスワードは正しく更新されました"
        redirect_to root_url
      else
        flash[:alert] = "パスワードを6文字以上で入力してください"
        render "edit_password"
      end
    else
      @user.errors.add(:password, "パスワードが一致しません")
      render "edit_password"
    end
  end

  def edit_password
  end

  def favorite
    @favorites_theater = @user.likees(Post)
  end

  def destroy
    @user.deleted_flg = User.switch_flg(@user.deleted_flg)
    @user.save
    sign_out(@user)
    redirect_to root_path, notice: "退会処理が完了しました" 
  end

  private
    def user_params
      params.permit(:name, :email, :birthday, :sex, :profile, :password, :password_confirmation, :deleted_flg, :image) 
    end

    def set_user
      @user = current_user
    end

    def password_set?
      user_params[:password].present? && user_params[:password_confirmation].present? ? true : false
    end
end
