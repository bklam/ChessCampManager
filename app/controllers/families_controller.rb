class FamiliesController < ApplicationController
  before_action :set_family, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    @active_families = Family.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_families = Family.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    @family_students = @family.students
  end

  def new
    @family = Family.new
    @family.students.build
  end

  def edit
  end

  def create
    @family = Family.new(family_params)
    if @family.save
      redirect_to @family, notice: "The #{@family.family_name} family was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @family.update(family_params)
      redirect_to @family, notice: "The #{@family.family_name} family was revised in the system."
    else
      render action: 'new'
    end
  end

  def destroy
    @family.destroy
    redirect_to families_url, notice: "Families cannot be removed from the system."
  end

  private
    def set_family
      @family = Family.find(params[:id])
    end

    def family_params
      params.require(:family).permit(:family_name, :parent_first_name, :email, :phone, :active, students_attributes:[:id, :first_name, :last_name, :date_of_birth, :rating, :active])
    end
end