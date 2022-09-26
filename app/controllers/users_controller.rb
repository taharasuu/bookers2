class UsersController < ApplicationController
   before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
    @book = Book.new
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def index
    @users = User.all
    @user = current_user
  end

  def edit
    @user = current_user
    if @user == current_user
      render "edit"
    else
      redirect_to users_path
    end
  end

  def update
    user = current_user
    if user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(current_user)
    else
      @user = user
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :get_profile_image)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end

end
