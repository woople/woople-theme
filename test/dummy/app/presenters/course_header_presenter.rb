class CourseHeaderPresenter < SimpleDelegator
  def initialize(course)
    super(course)
  end

  def title
    __getobj__.name
  end

end
