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
  
  it "should be graduated if it has no teacher" do
    child101 = students(:child101)

    Student.graduated.include?(child101).should == true
  end
  
  it "should have a fullname" do
    child101 = students(:child101)
    child101.fullname.should == "Patrick Stewart"
  end

  it "should have a teacher name" do
    child101 = students(:child01)
    child101.teachername.should == "Teacher"
  end
end

