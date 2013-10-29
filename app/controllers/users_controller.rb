class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Your user was saved!"
      redirect_to root_path
    else
      render :new   # render the new template
    end
  end

  def show
  end

  def edit
  end

  def update 
    if @user.update(user_params)
      flash[:notice] = 'This user was updated!'
      redirect_to user_path(@user)    #, notice = 'This post was updated!'
    else
      render :root_path
    end  
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :time_zone)
  end

  def set_user
    # @user = User.find(params[:id])         # using user.id
    @user = User.find_by(slug: params[:id])  # using slug
  end
end
