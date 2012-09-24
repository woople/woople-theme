require 'spec_helper'

describe WoopleTheme::Dashboard::OrganizationAccountsPresenter do
  describe '#accounts' do
    data = [OpenStruct.new({ name: 'Account 1' }), OpenStruct.new({ name: 'Account 2' })]

    subject { WoopleTheme::Dashboard::OrganizationAccountsPresenter.new(data).accounts }

    it 'returns the accounts as is' do
      should eq(data)
    end
  end
end
