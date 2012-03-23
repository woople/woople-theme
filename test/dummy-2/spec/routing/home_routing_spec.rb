require 'spec_helper'

describe "Home Routing" do
  it "routes / to the home controller" do
    { get: root_path }.should route_to(controller: 'home', action: 'show')
  end
end
