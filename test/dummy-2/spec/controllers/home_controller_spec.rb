require 'spec_helper'

describe HomeController do

  context "#show" do
    before do
      get :show
    end

    it { should respond_with :ok }

  end
end
