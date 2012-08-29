class Duration
  def self.format_time(milliseconds)
    return "0:00" if milliseconds <= 0

    hours   = milliseconds.to_i / 3600000
    minutes = milliseconds.to_i / 60000 % 60
    seconds = milliseconds/1000.0 % 60

    if hours > 0
      "%i:%02i:%02i" % [ hours, minutes, seconds ]
    else
      "%i:%02i" % [ minutes, seconds ]
    end
  end
end
