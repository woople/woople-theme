class BrowseController < ApplicationController
  layout 'theme'

  before_filter :set_course_names

  def video
    @video = { name: 'My Video' }
    render 'course'
  end

  private

  def set_course_names
    @course_names = ["My Really Long Course Name That Might Have to Do With Sales", "Anatomy of Backbone.js", "Rails Testing for Zombies", "CSS Cross-Country", "CoffeeScript", "jQuery Air: Captain's Log", "Natural Language Processing", "Game Theory", "Probabilistic Graphical Models", "Design and Analysis of Algorithms I", "Human-Computer Interaction"]
  end
end
