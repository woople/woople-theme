require 'spec_helper'

describe WoopleTheme::Dashboard::PointsPresenter do
  describe "#percent_complete" do
    describe "when total_points is 0" do
      let(:data) { data = OpenStruct.new({ earned: 1, total: 0 }) }

      subject { WoopleTheme::Dashboard::PointsPresenter.new(data).percent_complete }

      it "should return 100 when points_total is 0" do
        subject.should eq(100)
      end
    end

    describe "when total_points is not 0" do
      let(:data) { data = OpenStruct.new({ earned: 1, total: 3 }) }

      subject { WoopleTheme::Dashboard::PointsPresenter.new(data).percent_complete }

      it "should return the percent points_earned / points_total" do
        subject.should eq(33)
      end
    end
  end
end
