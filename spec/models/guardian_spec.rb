require 'spec_helper'

describe Guardian do
  fixtures :all

  describe "relation to student" do
    it "has zero or more students" do
      u01 = guardians(:u01)
      u01.students.count.should == 1
    end
  end
end
