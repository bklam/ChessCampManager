class RegistrationsController < ApplicationController
  authorize_resource

  def index
  end

  def show
  end

  def new
    @registration = Registration.new
  end

  def edit
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.save
      redirect_to camps_url, notice: "The registration for #{@registration.student.proper_name} to the #{@registration.camp.better_name} camp was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @registration.update(registration_params)
      redirect_to camps_url, notice: "The registration for #{@registration.student.proper_name} to the #{@registration.camp.better_name} camp was revised the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @registration.destroy
    redirect_to camps_url, notice: "The registration for #{@registration.student.proper_name} to the #{@registration.camp.better_name} camp was removed from the system."
  end

  private
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:id, :camp_id, :student_id, :payment_status, :points_earned)
    end
end
