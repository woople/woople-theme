require 'spec_helper'

describe WoopleTheme::Dashboard::AccountUserPresenter do
  describe '#image' do
    context 'no image' do
      subject do
        data = OpenStruct.new image: '/assets/retina_thumb/missing.png', name: 'GOATSE', member_dashboard_path: 'GOATSE', status_color: :red, status_description: 'GOATSE'
        WoopleTheme::Dashboard::AccountUserPresenter.new(data).image
      end

      it 'returns the missing profile path' do
        should eq 'woople-theme/missing-profile.png'
      end
    end

    context 'has image' do
      profile_image_url = 'https://woople.s3.amazonaws.com/gwar.jpg'

      subject do
        data = OpenStruct.new image: profile_image_url, name: 'GOATSE', member_dashboard_path: 'GOATSE', status_color: :red, status_description: 'GOATSE'
        WoopleTheme::Dashboard::AccountUserPresenter.new(data).image
      end

      it 'returns the profile image url as is' do
        should eq profile_image_url
      end
    end
  end
end
