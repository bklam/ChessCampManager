class UserController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "#{@user.instructor.proper_name} was added to the system"
    else
      render action: 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "#{@user.instructor.proper_name} was revised to the system"
    else
      redner action: 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to user_url, notice: "The user #{@user.username} was removed from the system"
  end

  def user_params
      params.require(:user).permit(:username, :password_digest, :instructor_id, :role, :active)
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end
end