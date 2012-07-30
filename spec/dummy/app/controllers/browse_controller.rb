require 'ostruct'

class BrowseController < ApplicationController
  layout 'theme'

  helper_method :random_unit, :random_video

  def initialize(*args)
    super(*args)
    @id_generator = create_id_generator
  end

  def video
    @course = random_course

    @video  = OpenStruct.new(
      name: video_names.sample,
      src: 'http://video-js.zencoder.com/oceans-clip.mp4',
      liked?: true
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

  def assessment
    @assessment_form = random_assessment_result(false)
  end

  def assessment_result
    @assessment_form = random_assessment_result(true)
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
      assessment: random_assessment(unit_index),
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

  def random_assessment(assessment_id)
    OpenStruct.new(
      assessment_id: assessment_id,
      questions_asked: rand(5..15),
      pass_requirement: [50, 75, 100].sample,
      estimated_duration: rand(5..25),
      enabled?: [true, false].sample,
      startable?: [true, false].sample,
      url: '#',
      relearnings: rand(0..7).times.collect { |index| random_video(index, [true, false].sample, true, true) },
      history: rand(0..7).times.collect { random_history_item },
      completed?: [true, false].sample
    ).tap { |assessment| assessment.send 'passed?=', [true, false].sample if [true, false].sample }
  end

  def random_history_item
    OpenStruct.new(
      completed_at: Time.new([2010, 2011, 2012].sample, rand(1..12), rand(1..28), rand(0..12), rand(0..59), rand(0..59)),
      score: [40, 50, 70].sample,
      passed: [false, true].sample,
      url: '/assessment_result'
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

  def random_assessment_result(submitted = false)
    OpenStruct.new(
      description: '"Hairy Forms" unit of "Pagination" course',
      questions: rand(10..13).times.collect { random_question(submitted) },
      course_path: '/course',
      copyright: 'Copyright (c) 2012 Apple Inc. All rights reserved.',
      submit_path: "/course",
      submitted?: submitted,
      completed_at: Time.new([2010, 2011, 2012].sample, rand(1..12), rand(1..28), rand(0..12), rand(0..59), rand(0..59)),
      passed?: [true, false].sample,
      correct_questions: rand(0..13),
      score: [40, 50, 70].sample
    )
  end


  def random_question(submitted = false)
    num_answers     = rand(2..5)
    submitted_index = submitted ? rand(0...num_answers) : nil
    correct_index   = rand(0...num_answers) # this is for submitted assessment results

    {
      id: generate_id,
      question: question_names.sample,
      answers: num_answers.times.map { |i| random_answer(i, correct_index, submitted_index, submitted) },
      submitted_index: submitted_index
    }
  end

  def random_answer(index, correct_index, submitted_index, submitted = false)
    answer = {
      index: index,
      text: answers.sample
    }

    if submitted
      answer.merge!({
        correct?: (correct_index == index) ? true : false,
        incorrect?: ((submitted_index == index) && (submitted_index != correct_index)) ? true : false,
        checked?: (submitted_index == index) ? true : false
      })
    end

    return answer
  end

  def question_names
    [
      'Does Marco Arment still have a financial stake in Tumblr?',
      'Why are software development task estimations regularly off by a factor of 2-3?',
      'What are some $1B+ markets ripe for disruption?',
      'What does it feel like to be the CEO of a start-up?',
      'How could Facebook monetize mobile?',
      'What filesystem does GitHub use for its repositories and why?',
      'What things has Paul Graham been very wrong about?',
      'What caused the turbulence and eventual downtime of Facebook on Thursday, May 31st, 2012?',
      'What is it like to always be the smartest person in the room?',
      'How is the mobile team at Facebook structured?',
      'Did anyone decline an offer to work at Instagram?'
    ]
  end

  def answers
    [
      'You think water moves fast? You should see ice.',
      'Now that there is the Tec-9, a crappy spray gun from South Miami.',
      'The path of the righteous man is beset on all sides by the iniquities of the selfish and the tyranny of evil men.',
      'Now that we know who you are, I know who I am.',
      'Well, the way they make shows is, they make one show.',
      'You listen: we go in there, and that nigga Winston or anybody else is in there, you the first motherfucker to get shot.',
      'Do you see any Teletubbies in here?',
      'Do you see a slender plastic tag clipped to my shirt with my name printed on it?',
      'Do you see a little Asian child with a blank expression on his face sitting outside on a mechanical helicopter that shakes when you put quarters in it?',
      'This gun is advertised as the most popular gun in American crime.',
      'Some pilots get picked and become television programs.'
    ]
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

  def generate_id
    @id_generator.call
  end

  private

  def create_id_generator
    id = 0
    Proc.new { id += 1 }
  end

end
