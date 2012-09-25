class ProfileLinks
  def self.generate
    {
      image: image,
      sections: sections
    }
  end

  def self.image
    nil # or provide your own default
  end

  def self.sections
    [
      [{ name: 'Account Settings', url: '#' }],
      [
        { name: 'Help', url: '#' },
        { name: 'Blog', url: '#' },
        { name: 'Twitter', url: '#' },
        { name: 'Feature Requests', url: '#' }
      ],
      [
        { name: 'Security', url: '#' },
        { name: 'Terms of Service', url: '#' },
        { name: 'Privacy', url: '#' }
      ],
      [{ name: 'Log out', url: '#' }]
    ]
  end
end
