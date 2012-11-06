class CourseHeaderPresenter < SimpleDelegator
  def initialize(course)
    super(course)
  end

  def title
    __getobj__.title
  end

end
