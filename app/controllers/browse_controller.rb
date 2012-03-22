class BrowseController < ApplicationController
  layout 'theme'

  def video
    get_course

    @video = OpenStruct.new(
      name: video_names.sample,
      src: 'http://www.youtube-nocookie.com/embed/k9bRT3JrykM?rel=0'
    )

    render 'course'
  end

  def show
    @content_items = []

    10.times do
      @content_items << OpenStruct.new(
        name: course_names.sample,
        completed: completed.sample,
        percent_complete: rand(100),
        image: images.sample,
        time_remaining: "#{rand(10)}:#{10+rand(60)}",
        time_total: "#{rand(10)}:#{10+rand(60)}",
        popularity: "230,323"
      )
    end

  end

  def course
    get_course
  end

  private

  def get_course
    @course = OpenStruct.new(
        name: course_names.sample,
        description: 'There should be a description for every course',
        completed: completed.sample,
        percent_complete: rand(100),
        image: images.sample,
        time_remaining: "#{rand(10)}:#{10+rand(60)}",
        time_total: "#{rand(10)}:#{10+rand(60)}",
        popularity: "230,323"
      )
  end

  def course_names
    ["My Really Long Course Name That Might Have to Do With Sales", "Anatomy of Backbone.js", "Rails Testing for Zombies", "CSS Cross-Country", "CoffeeScript", "jQuery Air: Captain's Log", "Natural Language Processing", "Game Theory", "Probabilistic Graphical Models", "Design and Analysis of Algorithms I", "Human-Computer Interaction"]
  end

  def video_names
    ["Classic Norm", "Changing lanes, like a boss", "Classic. I always laugh", "Why are G-rated insults funnier than R-rated ones?", "Beautiful rendition of a beautiful song", "Why don't you cry about?"]
  end

  def images
    ['course.png', 'missing.png', 'coffee.png', 'leadership.png', 'training.png', 'workshops.png', 'pen.png', 'innovation.png']
  end

  def completed
    ['completed', '']
  end
end
