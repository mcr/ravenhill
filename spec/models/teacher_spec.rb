require 'spec_helper'

describe Teacher do
  it "should have a list of students" do
    t = Teacher.new
    t.students.should == []
  end
end
