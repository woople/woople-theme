describe Duration do

  describe "format_time" do
    it 'returns the correctly formatted string' do
      Duration.format_time(-1).should == '0:00'
      Duration.format_time(0).should  == '0:00'
      Duration.format_time( time_in_ms(0,0,1)  ).should == "0:01"
      Duration.format_time( time_in_ms(0,1,0)  ).should == "1:00"
      Duration.format_time( time_in_ms(0,1,1)  ).should == "1:01"
      Duration.format_time( time_in_ms(1,0,0)  ).should == "1:00:00"
      Duration.format_time( time_in_ms(1,0,1)  ).should == "1:00:01"
      Duration.format_time( time_in_ms(1,1,0)  ).should == "1:01:00"
      Duration.format_time( time_in_ms(1,30,0) ).should == "1:30:00"
      Duration.format_time( time_in_ms(999,59,59) ).should == "999:59:59"
    end
  end
  def time_in_ms(hour, minute, second)
      second_multiplier = 1000
      minute_multiplier = second_multiplier * 60
      hour_multiplier = minute_multiplier * 60

      time = hour * hour_multiplier + minute * minute_multiplier + second * second_multiplier
  end
end
