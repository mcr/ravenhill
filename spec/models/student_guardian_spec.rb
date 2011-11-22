require 'spec_helper'

describe StudentGuardian do
  fixtures :all
  it "should have a student" do
    o1 = student_guardians(:o1)
    o1.student.should be   # not nil
  end
  it "should have a guardian" do
    o1 = student_guardians(:o1)

    o1.guardian.should be  # not nil
  end
end
