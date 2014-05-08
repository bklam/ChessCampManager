class HomeController < ApplicationController
  def index
    if logged_in?
      @instructor = Instructor.find(current_user.instructor_id)
      @personal_upcoming_camps = @instructor.camps
    end
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
