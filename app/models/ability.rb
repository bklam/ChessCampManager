class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    user ||= User.new # guest user (not logged in)

    # set authorizations for different user roles
    if user.role? :admin
      can :manage, :all
    elsif user.role? :instructor
      can :show, Instructor do |instructor|
        instructor.id == user.instructor_id
      end

      can :update, Instructor do |instructor|
        instructor.id == user.instructor_id
      end

      can :read, Camp do |this_camp|
        my_camps = user.instructor.camps.map(&:id)
        my_camps.include? this_camp.id
      end

      can :read, Student do |this_student|
        my_students = user.instructor.camps.map{|v| v.students.map{|c| c.id}}.flatten
        my_students.include? this_student.id
      end
    else
      can :read, Camp
      can :read, Curriculum
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
  end
end
