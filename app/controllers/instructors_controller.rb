class InstructorsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :set_instructor, only: [:show, :edit, :update, :destroy]

  def index
    @active_instructors = Instructor.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_instructors = Instructor.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    @upcoming_camps = @instructor.camps.upcoming.chronological
    @past_camps = @instructor.camps.past.chronological
  end

  def new
    @instructor = Instructor.new
    @instructor.build_user
  end

  def edit
    # reformating the phone so it has dashes when displayed for editing (personal taste)
    @instructor.phone = number_to_phone(@instructor.phone)
    if @instructor.user.nil?
      @instructor.build_user
    end
  end

  def create
    @instructor = Instructor.new(instructor_params)
    @user = User.new(params[:user_attributes])
    if @instructor.save and @user.save
      redirect_to @instructor, notice: "#{@instructor.proper_name} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @instructor.user.nil?
      @user = User.new(params[:user_attributes])
    else
      @user = @instructor.user
    end
    if @instructor.update(instructor_params) and @user.update(params[:user_attributes])
      redirect_to @instructor, notice: "#{@instructor.proper_name} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @instructor.destroy
    redirect_to instructors_url, notice: "#{@instructor.proper_name} was removed from the system."
  end

  private
    def set_instructor
      @instructor = Instructor.find(params[:id])
    end

    def instructor_params
      params.require(:instructor).permit(:first_name, :last_name, :bio, :email, :phone, :active, user_attributes:[:id, :username, :password, :role, :password_confirmation])
    end
end
