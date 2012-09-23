require 'spec_helper'

describe Student do
  fixtures :all

  describe "relation to guardian" do
    it "has zero or more guardians" do
      child01 = students(:child01)
      child01.guardians.count.should == 1
    end
  end
  
  it "should have a teacher" do
    s = Student.new
    s.teacher.should be_nil
  end
end

