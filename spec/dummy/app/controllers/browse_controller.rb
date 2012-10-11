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
      desktop_src: desktop_src,
      mobile_src: mobile_src,
      streamer: 'unknown',
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

  def member_dashboard
    @presenter = OpenStruct.new(
      status_color: [:red, :yellow, :green].sample,
      status_description: '3 essentials and 123 elective points required.',
    )

    @essentials_presenter = essentials
    @electives_presenter  = electives
  end

  def organization_dashboard
    @presenter = OpenStruct.new(
      status_color: [:red, :yellow, :green].sample,
      status_description: 'The organization will be on track when the owner as well as 7 more team-members turn green.',
      accounts: rand(1..3).times.collect { random_account }
    )
  end

  def personal_report
    @presenter = OpenStruct.new({
      reports: [
        {
          name: 'Daily',
          type: 'week',
          data_path: personal_report_data_path(format: :json),
          download_path: personal_report_data_path(format: :csv)
        },{
          name: 'Weekly',
          type: 'month',
          data_path: personal_report_data_path(format: :json),
          download_path: personal_report_data_path(format: :csv)
        },{
          name: 'Monthly',
          type: 'annual',
          data_path: personal_report_data_path(format: :json),
          download_path: personal_report_data_path(format: :csv)
        }
      ]
    })

    respond_to do |wants|
      wants.html
      wants.json { render json: sample_report_data, status: :ok }
    end
  end

  private

  def sample_report_data
    data = []

    5.days.ago.to_date.upto(0.days.ago.to_date) do |date|
      data << {
        primary_name: date,
        secondary_name: "",
        views: (0..20).to_a.sample,
        relearns: (0..10).to_a.sample,
        grade: 0
      }
    end

    data
  end

  def random_account
    {
      name: ['Account Name', 'Very Very Very Very Very Very Long Account Name'].sample,
      users: rand(1..4).times.collect { random_user }
    }
  end

  def random_user
    {
      image: '/assets/retina_thumb/missing.png',
      name: 'Christopher Mudiappahpillai',
      member_dashboard_path: '/member-dashboard',
      status_color: [:red, :yellow, :green].sample,
      status_description: '3 essentials and 123 elective points required.'
    }
  end

  def essentials
    OpenStruct.new(
      essentials_remaining:  rand(0..5).times.collect { |index| random_course },
      essentials_completed:  rand(0..5).times.collect { |index| random_course },
      essentials_exceptions: rand(3..5).times.collect { |index| random_essential_exception },
      enabled?: true
    )
  end

  def electives
    OpenStruct.new(
      electives_history: rand(3..5).times.collect { |index| random_course },
      electives_exceptions: rand(3..5).times.collect { |index| random_elective_exception },
      points_earned: rand(0..10),
      points_total: rand(0..190),
      enabled?: true
    )
  end

  def random_essential_exception
    OpenStruct.new(
      name: course_names.sample,
      description: exception_reasons.sample,
      url: '/course',
      completed_on: Time.at(rand * Time.now.to_i)
    )
  end

  def random_elective_exception
    total_points = [10, 20].sample

    OpenStruct.new(
      name: exception_reasons.sample,
      description: total_points,
      completed_on: Time.at(rand * Time.now.to_i)
    )
  end

  def random_course
    course_completed    = completed.sample
    course_completed_on = course_completed == true ? Time.at(rand * Time.now.to_i) : nil

    total_points   = [10, 20].sample
    current_points = course_completed == true ? total_points : (1..(total_points - 1)).to_a.sample

    OpenStruct.new(
      name: course_names.sample,
      description: 'Here is a sample description',
      url: '/course',
      completed?: course_completed,
      completed_on: course_completed_on,
      percent_complete: rand(100),
      image: images.sample,
      time_remaining: '4:56',
      time_total: '12:34',
      popularity: "230,323",
      certification_metadata: certification_metadata.sample,
      units: rand(1..3).times.collect { |index| random_unit(index) },
      current_points: current_points,
      total_points: total_points
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
      url: '/assessment-result'
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
      url: '/video',
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

  def exception_reasons
    ["Dog ate homework", "Late Arrival", "Technical Error", "Attended Live Event"]
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

  def create_id_generator
    id = 0
    Proc.new { id += 1 }
  end

  def mobile_src
    default_src
  end

  def desktop_src
    default_src
  end

  def default_src
    'http://video-js.zencoder.com/oceans-clip.mp4'
  end

end
