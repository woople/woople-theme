require 'ostruct'

class BrowseController < ApplicationController
  layout 'theme'
  
  helper_method :random_unit, :random_video

  def video
    @course = random_course

    @video = OpenStruct.new(
      name: video_names.sample,
      src: 'http://video-js.zencoder.com/oceans-clip.mp4'
    )

    render 'course'
  end

  def show
    @selection = 'continue-learning'

    @content_items = []

    10.times do
      @content_items << random_course
    end
  end

  def course
    @course = random_course
  end
  
  def search
    @content_items = []

    3.times do
      @content_items << random_course
    end
  end

  private

  def random_course
    OpenStruct.new(
      name: course_names.sample,
      description: 'Here is a sample description',
      url: '/course',
      completed?: completed.sample,
      percent_complete: rand(100),
      image: images.sample,
      time_remaining: rand(10000),
      time_total: rand(10000),
      popularity: "230,323",
      certification_metadata: certification_metadata.sample,
      units: rand(1..3).times.collect { |index| random_unit(index) }
    )
  end

  def random_unit(unit_index = 0, enabled = false, completed_videos = 3)
    OpenStruct.new(
      name: course_names.sample,
      enabled: (unit_index == 0),
      assessment: random_assessment,
      completed: 2,
      videos: rand((completed_videos+1)..(completed_videos*3)).times.collect { |index| 
        random_video("#{unit_index}_#{index}", 
                     (index + 1 <= completed_videos) ? true : false,
                     (index <= completed_videos) ? true : false,
                     (unit_index == 0)
                    )
      },
      downloads: [random_download(unit_index == 0)]
    )
  end

  def random_assessment
    OpenStruct.new(
      questions_asked: rand(5..15),
      pass_requirement: [50, 75, 100].sample,
      estimated_duration: rand(5..25),
      enabled?: [true, false].sample,
      url: [nil, '#'].sample,
      relearnings: rand(0..7).times.collect { |index| random_video(index, true, true, true) },
      history: rand(0..7).times.collect { random_history_item }
    )
  end

  def random_history_item
    OpenStruct.new(
      completed_at: Time.new([2010, 2011, 2012].sample, rand(1..12), rand(1..28), rand(0..12), rand(0..59), rand(0..59)),
      score: [40, 50, 70].sample,
      passed: [false, true].sample,
      url: '#'
    )
  end

  def random_download(unit_enabled)
    OpenStruct.new(
      name: "Reference Guide",
      url: '#',
      enabled: unit_enabled,
      completed: false
    )
  end

  def random_video(index, completed, enabled, unit_enabled)
    OpenStruct.new(
      id: index,
      name: video_names.sample,
      url: '/course/video',
      duration: rand(50000...500000),
      completed: completed && unit_enabled,
      enabled: enabled && unit_enabled
    )
  end

  def course_names
    ["My Really Long Course Name That Might Have to Do With Sales", "Anatomy of Backbone.js", "Rails Testing for Zombies", "CSS Cross-Country", "CoffeeScript", "jQuery Air: Captain's Log", "Natural Language Processing", "Game Theory", "Probabilistic Graphical Models", "Design and Analysis of Algorithms I", "Human-Computer Interaction"]
  end

  def video_names
    ["Classic Norm", "Changing lanes, like a boss", "Classic. I always laugh", "Why are G-rated insults funnier than R-rated ones?", "Beautiful rendition of a beautiful song", "Why don't you cry about?", "Words Matter", "Absorption Strategy", "Take It In", "Restate", "Provide Assurance", "Question Up", "Relieve Pressure", "Escape Route", "Bridging", "FBV Strategy", "Minor Point Agreement", "Good Hands Closing Recap"]
  end

  def images
    ['course.png', nil, 'coffee.png', 'leadership.png', 'training.png', 'workshops.png', 'pen.png', 'innovation.png']
  end

  def completed
    [true, false]
  end

  def certification_metadata
    [nil, "Essential", "+10 pts"]
  end
end
