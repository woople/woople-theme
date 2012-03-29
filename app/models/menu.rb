class Menu
  def self.generate(selection)
    [continue_learning(selection), certification, featured, topics]
  end

  def self.continue_learning(selection)
    {
      links: [ { name: 'Continue Learning', url: '/', featured: true, selected: (selection == 'continue-learning')  } ]
    }
  end

  def self.certification
    {
      name: 'Certification',
      links: [
        { name: 'Progress',    url: '#', featured: true, certification_badge: 'red' },
        { name: 'Essential',   url: '#', featured: true, badge: '5 courses' },
        { name: 'Elective',    url: '#', featured: true, badge: '44 points' },
        { name: 'Live Events', url: '#', featured: true }
      ]
    }
  end

  def self.featured
    {
      name: 'Featured',
      links: [
        { name: 'Popular', url: '#', featured: true },
        { name: 'Favourites', url: '#', featured: true }
      ]
    }
  end

  def self.topics
    {
      name: 'Topics',
      links: category_names.collect { |name| cat(name) }
    }
  end

  def self.category_names
    [
      "Advice", 
      "Agency Best Practices", 
      "Allstate Workout 1", 
      "Allstate Workout 2", 
      "Allstate Workout 2012", 
      "Allstate Workout 3",
      "California Region",
      "Care Sell Quote Close",
      "Executive Messages",
      "Grid Square",
      "Interviews",
      "Leadership",
      "Live Events",
      "Motivation",
      "Personal Development",
      "Sales Quick Tips",
      "Woople Help"
    ]
  end

  def self.cat(name)
    { name: name, url: '#' }
  end

end
