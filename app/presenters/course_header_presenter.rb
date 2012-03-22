class CourseHeaderPresenter < SimpleDelegator
  def initialize(course)
    @course = course

    super(course)
  end

  def title
    @course.name
  end

end
