#NOTE: THIS IS NOT A REAL PRESENTER, MAKE YOUR OWN
class ContentItemPresenter < SimpleDelegator
  def initialize(content_item)
    super(content_item)
  end

  def certification_type(&block)
    course_types = [nil, "Essential", "+10 pts"] 
    course_type = course_types.sample
    yield(course_type) if course_type.present?
  end
end
