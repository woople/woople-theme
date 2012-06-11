describe AssessmentFormPresenter do
  describe '#render_copyright' do
    describe 'when the copyright is not present' do
      subject { AssessmentFormPresenter.new stub(copyright: '') }

      it 'does not yield' do
        yielded = false
        subject.render_copyright { yielded = true }
        yielded.should == false
      end
    end

    describe 'when the copyright is present' do
      subject { AssessmentFormPresenter.new stub(copyright: 'Copyright (c) 2012 Apple Inc. All rights reserved.') }

      it 'yields' do
        yielded = false
        subject.render_copyright { yielded = true }
        yielded.should == true
      end
    end
  end
end