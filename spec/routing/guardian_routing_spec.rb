require "spec_helper"

describe GuardiansController do
  describe "routing" do
    it "should have an optin url" do
      {
	:get => "/guardians/10/optin?token=ABCDABCD"
      }.should route_to(:controller => "guardians",
			:action => "optin",
			:id => "10")
    end

    it "should have an wrongemail url" do
      {
	:get => "/guardians/10/wrongemail?token=ABCDABCD"
      }.should route_to(:controller => "guardians",
			:action => "wrongemail",
			:id => "10")
    end

    it "should post to a wrongemail url" do
      {
	:post => "/guardians/10/confirm_wrongemail?token=ABCDABCD"
      }.should route_to(:controller => "guardians",
			:action => "confirm_wrongemail",
			:id => "10")
    end

    it "should post to an optin url" do
      {
	:post => "/guardians/10/confirm_optin?token=ABCDABCD"
      }.should route_to(:controller => "guardians",
			:action => "confirm_optin",
			:id => "10")
    end

  end
end
