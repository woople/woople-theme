require 'spec_helper'

describe WoopleTheme::Dashboard::PointsPresenter do

  describe "#percent_complete" do

    subject do
      data = OpenStruct.new({ earned: 1, total: 3 })
      WoopleTheme::Dashboard::PointsPresenter.new(data).percent_complete
    end

    it "should return the percent points_earned / points_total" do
      subject.should eq(33)
    end
  end
end
